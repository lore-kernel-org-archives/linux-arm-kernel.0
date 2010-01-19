From: ashbertslists@gmail.com (Ashwin Chaugule)
Date: Tue, 19 Jan 2010 11:16:36 -0500
Subject: [RFC 07/18] arm: mm: retry on QSD icache parity errors
In-Reply-To: <ad7a95ae1001181042j3ae165dfkb70d43d983b808f9@mail.gmail.com>
References: <1263250057-26692-1-git-send-email-dwalker@codeaurora.org>
	<1263250057-26692-8-git-send-email-dwalker@codeaurora.org>
	<ad7a95ae1001181042j3ae165dfkb70d43d983b808f9@mail.gmail.com>
Message-ID: <ad7a95ae1001190816n3c93d159n6178c51a60f581f1@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jan 18, 2010 at 1:42 PM, Ashwin Chaugule
<ashbertslists@gmail.com> wrote:

>> +static int
>> +do_imprecise_ext(unsigned long addr, unsigned int fsr, struct pt_regs *regs)
>> +{
>> +#ifdef CONFIG_ARCH_MSM_SCORPION
>> + ? ? ? unsigned int regval;
>> + ? ? ? static unsigned char flush_toggle;
>> +
>> + ? ? ? asm("mrc p15, 0, %0, c5, c1, 0\n" /* read adfsr for fault status */
>> + ? ? ? ? ? : "=r" (regval));
>> + ? ? ? if (regval == 0x2) {
>> + ? ? ? ? ? ? ? /* Fault was caused by icache parity error. Alternate
>> + ? ? ? ? ? ? ? ?* simply retrying the access and flushing the icache. */
>> + ? ? ? ? ? ? ? flush_toggle ^= 1;
>> + ? ? ? ? ? ? ? if (flush_toggle)
>> + ? ? ? ? ? ? ? ? ? ? ? asm("mcr p15, 0, %0, c7, c5, 0\n"
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? :
>> + ? ? ? ? ? ? ? ? ? ? ? ? ? : "r" (regval)); /* input value is ignored */
>
> Wouldn't you need regval = 0 here, to clear the EFSR ?
>
>

Gah. Nevermind. Need to write 1 to clear this reg. Alternating methods
to clear regs, is just .. confusing. ;)
