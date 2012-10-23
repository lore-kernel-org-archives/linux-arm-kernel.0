From: khilman@deeprootsystems.com (Kevin Hilman)
Date: Tue, 23 Oct 2012 12:17:23 -0700
Subject: OMAP baseline test results for v3.7-rc1
In-Reply-To: <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
 (Jean Pihet's message of "Mon, 22 Oct 2012 18:12:06 +0200")
References: <alpine.DEB.2.00.1210180517450.8674@utopia.booyaka.com>
 <alpine.DEB.2.00.1210191645390.10773@utopia.booyaka.com>
 <alpine.DEB.2.00.1210200611150.9865@utopia.booyaka.com>
 <CAORVsuUkU3iTTFcXfYJ=_FntjiTR33Gs4z9OsNEn2Cxq7Ef-qA@mail.gmail.com>
Message-ID: <87fw5580cc.fsf@deeprootsystems.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Jean Pihet <jean.pihet@newoldbits.com> writes:

> Hi,
>
> On Sat, Oct 20, 2012 at 8:14 AM, Paul Walmsley <paul@pwsan.com> wrote:
>> Hi Jean
>>
>> On Fri, 19 Oct 2012, Paul Walmsley wrote:
>>
>>> On Thu, 18 Oct 2012, Paul Walmsley wrote:
>>>
>>> > Here are some basic OMAP test results for Linux v3.7-rc1.
>>> > Logs and other details at http://www.pwsan.com/omap/testlogs/test_v3.7-rc1/
>>
>> ...
>>
>>> > Failing tests: needing investigation
>>> > ------------------------------------
>>> >
>>> > Boot tests:
>>>
>>> * 3530ES3 Beagle: I2C timeouts during userspace init
>>>   - May be related to the threaded IRQ conversion of the I2C driver
>>>   - Unknown cause
>>
>> This one turned out to be caused by:
>>
>> commit 3db11feffc1ad2ab9dea27789e6b5b3032827adc
>> Author: Jean Pihet <jean.pihet@newoldbits.com>
>> Date:   Thu Sep 20 18:08:03 2012 +0200
>>
>>     ARM: OMAP: convert I2C driver to PM QoS for MPU latency constraints
>>
>>
>> Reverting this commit causes the problem to go away, but since the OMAP PM
>> constraint code was removed as well, it's unlikely that a simple revert is
>> the right thing to do.
>>
>> Jean could you please investigate and fix this?
> I tried the latest l-o with omap2plus defconfig on my Beagleboard B5
> (ES2.1) and could not reproduce the problem.
> I do not have the I2C error messages at boot, nor at user space start
> up. I tried to read/write the TWL RTC, successfully.
>
> Another difference is the bootloader images. I have the following:
> - Texas Instruments X-Loader 1.4.2 (Feb  3 2009 - 15:34:17)
> - U-Boot 2009.01-dirty (Feb 19 2009 - 12:22:31)
> Could you send your bootloader images?
>
> I noticed you have I2C error messages in U-Boot, could that be the
> cause of the I2C lock-up?

FWIW, I have a relatively recent mainline u-boot+SPL:

U-Boot SPL 2012.04.01 (Jul 03 2012 - 07:07:04)
U-Boot 2012.04.01 (Jul 03 2012 - 07:07:04)

And I see I2C error messages from u-boot too:

timed out in wait_for_pin: I2C_STAT=0
I2C read: I/O error

I think these are normal/expected since u-boot may be looking for
expansion cards.

Kevin
