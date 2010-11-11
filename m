From: vitja.makarov@gmail.com (Vitja Makarov)
Date: Thu, 11 Nov 2010 15:50:12 +0300
Subject: [AT91SAM9260] kernel hang in at91sam926x_pit_reset()
In-Reply-To: <201011111345.42080.alexander.stein@systec-electronic.com>
References: <AANLkTik1P9CNYu93ZDc3PU6e=17O8XBg=DdPo1a9VW6c@mail.gmail.com>
	<201011111345.42080.alexander.stein@systec-electronic.com>
Message-ID: <AANLkTi=ahWs+VidZpjPEBfUs5RZkv18XMDB0jCgrHA_r@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

2010/11/11 Alexander Stein <alexander.stein@systec-electronic.com>:
> On Thursday 11 November 2010, 12:41:48 Vitja Makarov wrote:
>> Hi!
>>
>> I've recently found that our new AT91SAM9260 boards does not work with
>> linux out of the box.
>> The only thing changed is CPU revision now it is "Rev. B' (old boards
>> used "Rev. A" CPUs)
>>
>>
>> So after uncompressing kernel it writes. "Booting kernel..." that's
>> all. Kernel hangs.
>>
>> I found that it hangs in ?at91sam926x_time.c:at91sam926x_pit_reset():
>>
>> Bit in AT91_PIT_PIVR register never clears... so I add timeout for
>> this loop and kernel boots as expected.
>>
>> static void at91sam926x_pit_reset(void)
>> {
>> <------>/* Disable timer and irqs */
>> <------>at91_sys_write(AT91_PIT_MR, 0);
>>
>> <------>/* Clear any pending interrupts, wait for PIT to stop counting */
>> <------>while (PIT_CPIV(at91_sys_read(AT91_PIT_PIVR)) != 0)
>> <------><------>cpu_relax();
>>
>> <------>/* Start PIT but don't enable IRQ */
>> <------>at91_sys_write(AT91_PIT_MR, (pit_cycle - 1) | AT91_PIT_PITEN);
>> }
>
> This won't work as you cannot set PIT_PITEN until the PIT has stopped
> (UserManuel 17.3), read as CPIV is 0. You should check if and why CPIV isn't
> increasing.
>
> Best regards
> Alexander
>

Could it be hardware bug? With revision A it works. Do you have
success on use rev B. CPUs?
May be the problem is in u-boot or initial loader?
