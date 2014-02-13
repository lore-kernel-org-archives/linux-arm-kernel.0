From: swarren@wwwdotorg.org (Stephen Warren)
Date: Wed, 12 Feb 2014 19:19:49 -0700
Subject: [PATCH] ARM: tegra: dalmore: fix irq trigger type
In-Reply-To: <52FC1BF2.8020003@nvidia.com>
References: <4fcfcfdbc86c37c6d47ec32cdbd987f3b406e9b5.1392147256.git.stefan@agner.ch>
 <20140211204737.GA1895@mithrandir>
 <30f0db808e7543d9ab6b077aa5e239f2@agner.ch> <52FBCDFD.1040902@wwwdotorg.org>
 <52FC1BF2.8020003@nvidia.com>
Message-ID: <52FC2BC5.5050705@wwwdotorg.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 02/12/2014 06:12 PM, Joseph Lo wrote:
> On 02/13/2014 03:39 AM, Stephen Warren wrote:
>> On 02/11/2014 02:21 PM, Stefan Agner wrote:
>>> Am 2014-02-11 21:47, schrieb Thierry Reding:
>>>> On Tue, Feb 11, 2014 at 09:11:32PM +0100, Stefan Agner wrote:
>>>>> Trigger type needs to be IRQ_TYPE_LEVEL_HIGH since the interrupt
>>>>> signal gets inverted by the PMC (configured by the invert-interrupt
>>>>> property).
...
>> For me, applying this patch actually *causes* an interrupt storm, rather
>> than preventing one. Yet without it, no interrupts occur at all. I
>> wonder if the driver has a bug where it's not correctly clearing all
>> interrupt status (e.g. something pre-existing before boot), so once the
>> polarity is set up correctly, the interrupt is stuck?
>>
>> Joseph,
>>
>> As the author of the patch that's being reverted, can you please comment
>> here?
>>
> 
> I had explained why I fixed this here.
> https://patchwork.kernel.org/patch/2832646/

Looking back at that conversation, I'm not convinced by your explanation.

Some questions:

What does the PMIC output for an IRQ signal? It sounds like SW can
select either active-high level, or active-low level. Which of those is
the HW default? Does the Linux kernel driver attempt to program the HW
to select one or the other? If so, how does it determine which option to
choose, and where's the code that does that?

For now, let's not worry about system suspend issues, what the GIC
supports, etc. I only want to know about the PMIC for now.

Once we know the answer to that question, we can correctly configure the DT.
