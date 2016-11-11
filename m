From: wens@csie.org (Chen-Yu Tsai)
Date: Fri, 11 Nov 2016 11:01:41 +0800
Subject: [PATCH v5 02/23] of: device: Export of_device_{get_modalias,
 uvent_modalias} to modules
In-Reply-To: <CAL_Jsq+Bw4XVEJY6V4Hn+D_OmqEcp_nLLrVT0_i+jX_guCqzfA@mail.gmail.com>
References: <20161018015636.11701-1-stephen.boyd@linaro.org>
 <20161018015636.11701-3-stephen.boyd@linaro.org>
 <CAGb2v66t8t3o0PxzaaBKnRvNP=CWG5nYud7Wjp27Q1x2baM4hg@mail.gmail.com>
 <147733850401.29612.2343965740004706258@sboyd-linaro>
 <20161025011632.GA23876@b29397-desktop>
 <147829269430.21688.2345895151880009021@sboyd-linaro>
 <20161107012920.GA10559@b29397-desktop>
 <CAGb2v66C15fU1b2+xNDV8Fv2kmmKXyUknA8=9wXztUcs8CNKLg@mail.gmail.com>
 <CAL_Jsq+Bw4XVEJY6V4Hn+D_OmqEcp_nLLrVT0_i+jX_guCqzfA@mail.gmail.com>
Message-ID: <CAGb2v66H1doBOdPPN9kz1vdNYx8gpgkF6s3UhTiXCCp0RZYKwg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Nov 11, 2016 at 5:42 AM, Rob Herring <robh@kernel.org> wrote:
> On Sun, Nov 6, 2016 at 7:56 PM, Chen-Yu Tsai <wens@csie.org> wrote:
>> On Mon, Nov 7, 2016 at 9:29 AM, Peter Chen <hzpeterchen@gmail.com> wrote:
>>> On Fri, Nov 04, 2016 at 01:51:34PM -0700, Stephen Boyd wrote:
>>>> Quoting Peter Chen (2016-10-24 18:16:32)
>>>> > On Mon, Oct 24, 2016 at 12:48:24PM -0700, Stephen Boyd wrote:
>>>> > > Quoting Chen-Yu Tsai (2016-10-24 05:19:05)
>>>> > > > Hi,
>>>> > > >
>>>> > > > On Tue, Oct 18, 2016 at 9:56 AM, Stephen Boyd <stephen.boyd@linaro.org> wrote:
>>>> > > > > The ULPI bus can be built as a module, and it will soon be
>>>> > > > > calling these functions when it supports probing devices from DT.
>>>> > > > > Export them so they can be used by the ULPI module.
>>>> > > > >
>>>> > > > > Acked-by: Rob Herring <robh@kernel.org>
>>>> > > > > Cc: <devicetree@vger.kernel.org>
>>>> > > > > Signed-off-by: Stephen Boyd <stephen.boyd@linaro.org>
>>>> > > > > ---
>>>> > > > >  drivers/of/device.c | 2 ++
>>>> > > > >  1 file changed, 2 insertions(+)
>>>> > > > >
>>>> > > > > diff --git a/drivers/of/device.c b/drivers/of/device.c
>>>> > > > > index 8a22a253a830..6719ab35b62e 100644
>>>> > > > > --- a/drivers/of/device.c
>>>> > > > > +++ b/drivers/of/device.c
>>>> > > > > @@ -225,6 +225,7 @@ ssize_t of_device_get_modalias(struct device *dev, char *str, ssize_t len)
>>>> > > > >
>>>> > > > >         return tsize;
>>>> > > > >  }
>>>> > > > > +EXPORT_SYMBOL_GPL(of_device_get_modalias);
>>>> > > > >
>>>> > > > >  int of_device_request_module(struct device *dev)
>>>> > > > >  {
>>>> > > > > @@ -290,6 +291,7 @@ void of_device_uevent(struct device *dev, struct kobj_uevent_env *env)
>>>> > > > >         }
>>>> > > > >         mutex_unlock(&of_mutex);
>>>> > > > >  }
>>>> > > > > +EXPORT_SYMBOL_GPL(of_device_uevent_modalias);
>>>> > > >
>>>> > > > This is trailing the wrong function.
>>>> > > >
>>>> > >
>>>> > > Good catch. Must have been some bad rebase.
>>>> > >
>>>> > > Peter, can you fix it while applying or should I resend this patch?
>>>> > >
>>>> >
>>>> > But, this is device tree patch. I can only get chipidea part and other
>>>> > USB patches if Greg agrees.
>>>> >
>>>>
>>>> Were you expecting Rob to take the drivers/of/* patches? Sorry I thought
>>>> Rob acked them so they could go through usb with the other changes.
>>>
>>> I am just worried about possible merge error when linus pulls both OF
>>> and USB tree. Greg, is it ok the OF patches through USB tree with OF
>>> maintainer's ack?
>>
>> May I suggest putting the OF patches on an immutable branch so other
>> subsystems can pull them in without pulling in the USB patches? At
>> least I want to use them in the I2C subsystem, and in the sunxi-rsb
>> driver.
>
> Do you have patches using this already. If not, it is starting to get
> a bit late for v4.10.
>
> I can apply this, but then you'll just be pulling in other DT patches.

Not sure what you mean by "using" this...

I have patches which use this to add DT-based modalias entries for
module auto-loading to i2c and sunxi-rsb that I haven't sent.

As far as DT usage goes, we already need this for the axp20x mfd driver.
There are 2 variants, i2c and sunxi-rsb. For the I2C variant a fix was
sent to fix module auto-loading by using the I2C client ID table:

    mfd: axp20x-i2c: Add i2c-ids to fix module auto-loading
    https://git.kernel.org/cgit/linux/kernel/git/lee/mfd.git/commit/?h=for-mfd-next&id=b7142a19321484bd7681aa547c1d50148c8e2825

But for the sunxi-rsb variant such a fix does not exist, as the bus
does not have a separate ID table. It uses DT exclusively.


Regards
ChenYu
