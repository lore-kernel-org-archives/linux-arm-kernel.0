From: vladimir_zapolskiy@mentor.com (Vladimir Zapolskiy)
Date: Wed, 16 Sep 2015 23:58:24 +0300
Subject: [PATCH v3 2/2] drm: bridge/dw_hdmi: add dw hdmi i2c bus adapter
 support
In-Reply-To: <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
References: <1440970470-7155-1-git-send-email-vladimir_zapolskiy@mentor.com>
 <CAD=FV=XZ4cY4o-=vL79GDE4m57B+Rw_Yr_QwtB6T7DbQNzmU0Q@mail.gmail.com>
Message-ID: <55F9D7F0.4070402@mentor.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Doug,

On 16.09.2015 23:04, Doug Anderson wrote:
> Hi,
> 
> On Sun, Aug 30, 2015 at 2:34 PM, Vladimir Zapolskiy
> <vladimir_zapolskiy@mentor.com> wrote:
>> The change adds support of internal HDMI I2C master controller, this
>> subdevice is used by default, if "ddc-i2c-bus" DT property is omitted.
>>
>> The main purpose of this functionality is to support reading EDID from
>> an HDMI monitor on boards, which don't have an I2C bus connected to
>> DDC pins.
>>
>> The current implementation does not support "I2C Master Interface
>> Extended Read Mode" to read data addressed by non-zero segment
>> pointer, this means that if EDID has more than 1 extension blocks,
>> EDID reading operation won't succeed, in my practice all tested HDMI
>> monitors have at maximum one extension block.
>>
>> Signed-off-by: Vladimir Zapolskiy <vladimir_zapolskiy@mentor.com>
>> ---
>> The change is based on today's v4.2, please let me know, if it should be rebased.
>>
>> The change has compilation dependency on I2CM_ADDRESS register name fix,
>> see http://lists.freedesktop.org/archives/dri-devel/2015-May/082980.html
>>
>> From http://lists.freedesktop.org/archives/dri-devel/2015-May/082981.html
>> v1 of the change was
>>
>>   Tested-by: Philipp Zabel <p.zabel@pengutronix.de>
>>
>> but I hesitate to add the tag here due to multiple updates in v2.
>>
>> Changes from v2 to v3, thanks to Russell:
>> - moved register field value definitions to dw_hdmi.h
>> - made completions uninterruptible to avoid transfer retries if interrupted
>> - use one completion for both read and write transfers as in v1, operation_reg is removed
>> - redundant i2c->stat = 0 is removed from dw_hdmi_i2c_read/write()
>> - struct i2c_algorithm dw_hdmi_algorithm is qualified as const
>> - dw_hdmi_i2c_adapter() does not modify struct dw_hdmi on error path
>> - dw_hdmi_i2c_irq() does not modify hdmi->i2c->stat, if interrupt is not for I2CM
>> - spin lock is removed from dw_hdmi_i2c_irq()
>> - removed spin lock from dw_hdmi_i2c_xfer() around write to HDMI_IH_MUTE_I2CM_STAT0 register
>> - split loop over message array in dw_hdmi_i2c_xfer() to validation and transfer parts
>> - added a mutex to serialize I2C transfer requests, i2c->lock is completely removed
>> - removed if(len) check from dw_hdmi_i2c_write(), hardware supports only len>0 transfers
>> - described extension blocks <= 1 limitation in the commit message
>> - a number of minor clean ups
>>
>> Changes from v1 to v2:
>> - fixed a devm_kfree() signature
>> - split completions for read and write operations
>>
>>  drivers/gpu/drm/bridge/dw_hdmi.c | 262 ++++++++++++++++++++++++++++++++++++++-
>>  drivers/gpu/drm/bridge/dw_hdmi.h |  19 +++
>>  2 files changed, 275 insertions(+), 6 deletions(-)
> 
> Not sure what the status of this patch is, but I'll make a few more
> suggestions in case they're helpful.

sure, all review comments are welcome.

I have in mind that Philipp asked to add an update to documentation, the
next version will contain the fixes.

> 
>> +static void dw_hdmi_i2c_init(struct dw_hdmi *hdmi)
>> +{
>> +       /* Set Fast Mode speed */
>> +       hdmi_writeb(hdmi, 0x0b, HDMI_I2CM_DIV);
> 
> If you're going to hardcode to something, it seems like hardcoding to
> standard mode might be better?  It's likely that users will plug into
> all kinds of broken / crappy HDMI devices out there.  I think you'll
> get better compatibility by using the slower mode, and EDID transfers
> really aren't too performance critical are they?
> 

Accepted. I don't know what are the exact divisors of master clock for
fast and standard modes, for reference I'll make a simple performance
test and publish its results. I expect that in standard mode SCL is
about 100KHz and in fast mode SCL is about 400KHz, and, if in standard
mode SCL is less than 100KHz, it will take more than 50ms to read out
512 bytes of data, which might be not acceptable from performance
perspective.

>> +
>> +       /* Software reset */
>> +       hdmi_writeb(hdmi, 0x00, HDMI_I2CM_SOFTRSTZ);
> 
> Unless there's a reason not to, it seems like the reset ought to be
> the first thing in this function (before setting the I2CM_DIV).  Even
> if it doesn't actually reset the speed on current hardware, it just
> seems cleaner.

It makes sense for me.

> 
>> +static int dw_hdmi_i2c_xfer(struct i2c_adapter *adap,
>> +                           struct i2c_msg *msgs, int num)
>> +{
>> +       struct dw_hdmi *hdmi = i2c_get_adapdata(adap);
>> +       struct dw_hdmi_i2c *i2c = hdmi->i2c;
>> +       u8 addr = msgs[0].addr;
>> +       int i, ret = 0;
>> +
>> +       dev_dbg(hdmi->dev, "xfer: num: %d, addr: %#x\n", num, addr);
>> +
>> +       for (i = 0; i < num; i++) {
>> +               if (msgs[i].addr != addr) {
>> +                       dev_warn(hdmi->dev,
>> +                                "unsupported transfer, changed slave address\n");
>> +                       return -EOPNOTSUPP;
>> +               }
>> +
>> +               if (msgs[i].len == 0) {
>> +                       dev_dbg(hdmi->dev,
>> +                               "unsupported transfer %d/%d, no data\n",
>> +                               i + 1, num);
>> +                       return -EOPNOTSUPP;
>> +               }
>> +       }
>> +
>> +       mutex_lock(&i2c->lock);
>> +
> 
> If I may make a suggestion, it's worth considering putting
> dw_hdmi_i2c_init() here and removing it from the dw_hdmi_bind()
> function.  There isn't any state kept between i2c transfers (each one
> is independent), so re-initting each time won't hurt.  ...and doing so
> has the potential to fix some things.

I think it is resourse wasteful, especially since it does not solve any
actual problem, if I understand your arguments correctly.

I'd like to see the I2C bus registered even if there is no ongoing
transfer, for instance running "modprobe i2c-dev; i2cdetect -l".

For information I notice that there is a movement of I2C bus
configuration/capture from bind() to probe() in DRM drivers, e.g. see
commit 53bdcf5f026c .

> On rk3288 there's at least one case where the i2c controller can get
> wedged and just totally stops working.  Although this particular wedge
> isn't fixed by calling dw_hdmi_i2c_init() (it needs a full controller
> reset to fix), it's possible that there may be other cases where the
> HDMI_I2CM_SOFTRSTZ fixes some bad state.

I don't know, may be the shared part of the driver should export a
reset() function for RK3288, if it (or its next version) helps?

Unlickily I don't possess an RK3288 power board, but in any case I would
appreciate, if you share your test, I'll try to reproduce the same
problem on iMX6.

At the moment I am inclided to preserve I2C bus registration in bind()

> Note: if you do that, you can just init HDMI_IH_MUTE_I2CM_STAT0 to
> 0x00 at the end of dw_hdmi_i2c_init() and skip the next statement...
> 
>> +       hdmi_writeb(hdmi, 0x00, HDMI_IH_MUTE_I2CM_STAT0);
> 
> 

With best wishes,
Vladimir
