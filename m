From: linux@rempel-privat.de (Oleksij Rempel)
Date: Wed, 24 Sep 2014 13:30:53 +0200
Subject: [PATCH v2 1/8] ARM: add mach-asm9260
In-Reply-To: <2748904.3BsN75JAH1@wuerfel>
References: <1411324904-14881-1-git-send-email-linux@rempel-privat.de>
 <54229533.8050607@rempel-privat.de>
 <20140924102542.GV5182@n2100.arm.linux.org.uk> <2748904.3BsN75JAH1@wuerfel>
Message-ID: <5422AB6D.7090406@rempel-privat.de>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Am 24.09.2014 um 12:33 schrieb Arnd Bergmann:
> On Wednesday 24 September 2014 11:25:42 Russell King - ARM Linux wrote:
>> On Wed, Sep 24, 2014 at 11:56:03AM +0200, Oleksij Rempel wrote:
>>> Am 24.09.2014 um 11:43 schrieb Russell King - ARM Linux:
>>>> The "why" is in the text from your oops dump.  That's precisely /why/ we
>>>> print that text - so that we know /why/ the fault happened.
>>>
>>> Here is oops message:
>>> http://pastebin.com/qYWeAyfV
>>>
>>> i can avoid this oops by setting size at least 0x2000 per register
>>> range. Do it mean my TLB supports only 8 KiB pages?
>>
>> No, it has nothing to do with the TLB.
>>
>> Unable to handle kernel paging request at virtual address c2802174
>> pgd = c0004000
>> [c2802174] *pgd=21805811, *pte=00000000, *ppte=00000000
>> Internal error: Oops: 7 [#1] PREEMPT ARM
>>
>> The number after the Oops: is the FSR value, which means "page translation
>> fault", and sure enough, the pgd/pte values show that there is no page
>> table entry at the faulting address.
>>
>> That's odd, because ioremap() aligns the size of the requested mapping up
>> to a multiple of the page size, and inserts page table entries according
>> to the rounded size.
>>
>> Where are you calling ioremap(), iounmap() etc?  IOW, please show your
>> code for this.
> 
> It's the clock driver from patch 5. It starts out with an ioremap of
> the clock controller node:
> 
> +               acc: clock-controller at 80040000 {
> +                       compatible = "alphascale,asm9260-clock-controller";
> +                       #clock-cells = <1>;
> +                       clocks = <&osc24m>;
> +                       reg = <0x80040000 0x500>;
> +               };
> 
> Oh, and there is the bug:
> 
> +       /* check for errors on leaf clocks */
> +       for (n = 0; n < MAX_CLKS; n++) {
> +               if (!IS_ERR(clks[n]))
> +                       continue;
> +
> +               pr_err("%s: Unable to register leaf clock %d\n",
> +                               np->full_name, n);
> +               goto fail;
> +       }
> +
> +       /* register clk-provider */
> +       clk_data.clks = clks;
> +       clk_data.clk_num = MAX_CLKS;
> +       of_clk_add_provider(np, of_clk_src_onecell_get, &clk_data);
> +fail:
> +       iounmap(base);
> +}
> 
> There should be a 'return' in front of the 'fail:', otherwise it
> get unmapped unconditionally.

Ouch... thank you!!!
Still weird why it was not always oopsing.

-- 
Regards,
Oleksij

-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 213 bytes
Desc: OpenPGP digital signature
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20140924/6ed577a2/attachment-0001.sig>
