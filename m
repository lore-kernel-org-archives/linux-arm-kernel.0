From: zonque@gmail.com (Daniel Mack)
Date: Mon, 09 Dec 2013 11:21:05 +0100
Subject: [PATCH 5/9] ARM: dts: provide DMA config to pxamci
In-Reply-To: <1386581672.7152.108.camel@host5.omatika.ru>
References: <1386348542-9584-1-git-send-email-ynvich@gmail.com>	
 <1386543229-1542-1-git-send-email-ynvich@gmail.com>	
 <1386543229-1542-6-git-send-email-ynvich@gmail.com>	
 <201312090233.58592.arnd@arndb.de> <52A587A0.1050503@gmail.com>
 <1386581672.7152.108.camel@host5.omatika.ru>
Message-ID: <52A59991.1060305@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/09/2013 10:34 AM, Sergei Ianovich wrote:
> On Mon, 2013-12-09 at 10:04 +0100, Daniel Mack wrote:
>> On 12/09/2013 02:33 AM, Arnd Bergmann wrote:
>>> On Sunday 08 December 2013, Sergei Ianovich wrote:
>>>> Non-dts implementation supply required DMA channel numbers as
>>>> IORESOURCE_DMA. However, there is was no way to get them from
>>>> device tree.
>>>
>>> I just wrote a lengthy reply to this email to explain in what ways
>>> you got it wrong, but then I saw that Daniel has already done all
>>> the work in the right way in August, so nevermind that.
>>>
>>> It hasn't made it upstream yet, but see http://list-archives.org/2013/08/07/linux-mtd-lists-infradead-org/patch-00-20-arm-pxa-move-core-and-drivers-to-dmaengine/f/3444199144
>>> for how it's done. Maybe Daniel can comment on the status of his
>>> patches.
>>
>> I recently rebased all my patches on top of 3.13-rc3, and will resend in
>> couple of days.
>>
>> The real problem here is that by reworking the DMA related PXA bits, all
>> drivers have to be changed at once, and a gradual transition seems
>> impossible. For that, I was asking for help in areas where I don't have
>> any hardware to test my patches on, but unfortunately, nobody got back
>> to me yet.
> 
> Nice to have Daniel in this conversation. Your patch series is a big and
> important work. However, I am not sure I will ever land as is exactly
> for this reason.

Well, I wouldn't be so certain about that statement. As I wrote in the
cover letter, most of the work is actually done, and I successfully
tested the new DMA support with a some of the drivers I ported. Others
were ported blindly, and in case of no reaction, I'd dare to merge them
and wait for people to report back in case of trouble.

The only real problem is the PXA camera driver, which does tricky things
like hot re-queuing of DMA descriptors. That one needs fixing before the
series can land.

> My proposal in to actually add new drivers for each platform device with
> DMA and mark new ones EXPERIMENTAL.

That would cause tree-wide cross-dependencies between drivers, because
the two DMA controllers can't be used at the same time, and the PXA
specific API will be unavailable when the mmp-dma driver is selected. My
patch series (and the DMA controller framework for that matter) aims for
the opposite - the unification of APIs and drivers.

> When they receive adequate testing
> we remove the tag and mark the old one OBSOLETE. When we have a new
> driver for every device presently supported, we will drop the whole old
> series.

Well, given the feedback I got for the series so far, I fear we'll be
off to maintain two drivers for each peripheral for a very long time.

I'd rather propose cracking the last nut that's left, and then get the
thing merged.

Arnd, Haojian? Any opinion here?



Daniel
