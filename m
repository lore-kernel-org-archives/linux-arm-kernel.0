From: zajec5@gmail.com (=?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?=)
Date: Wed, 25 Apr 2018 10:51:33 +0200
Subject: [PATCH] ARM: BCM5301X: Fix NAND ECC parameters for Linksys
 Panamera
In-Reply-To: <20180311100313.znonhesgh462rz65@osboxes>
References: <20180310171244.70299-1-npcomplete13@gmail.com>
 <CACna6rz1TeRbPq-60HkHz9A0TDn+iXtmXniE6FCiANpUmV-qrw@mail.gmail.com>
 <20180311100313.znonhesgh462rz65@osboxes>
Message-ID: <CACna6rxW0QvQWO1Oq77YFH3ry7+ycwPD1yWrJEhMHMPj_Z_zNA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11 March 2018 at 11:03, Vivek Unune <npcomplete13@gmail.com> wrote:
> Hi Rafa?,
>
> On Sat, Mar 10, 2018 at 10:41:04PM +0100, Rafa? Mi?ecki wrote:
>> On 10 March 2018 at 18:12, Vivek Unune <npcomplete13@gmail.com> wrote:
>> > Using BCH8 gives ecc errors and makes the router unsuable.
>> > Switching to BCH1 fixes these errors.
>>
>> Can you provide CFE's log messages starting with
>> "Decompressing...done" and up to the "Press Ctrl+C to stop in CFE"
>> please? I'd like to see what NAND info CFE prints there.
>
> See below. It does say BCH-8, however I can't get it to work.
>
> CFE log:
>
> Decompressing...done
> Found a Toshiba NAND flash:
> Total size:  128MB
> Block size:  128KB
> Page Size:   2048B
> OOB Size:    64B
> Sector size: 512B
> Spare size:  16B
> ECC level:   8 (8-bit)
> Device ID: 0x98 0xf1 0x80 0x15 0xf2 0x16
> find_devinfo: devinfo block found at 0x00180000!
>
> Press Ctrl+C to stop in CFE

This means that:
1) Default mode for your NAND controller is BCH8 (setup at hw level)
2) CFE uses BCH8 when programming flash with provided firmware

For maximum compatibility DTS should describe ECC as using BCH8 and
Linux should use BCH8.

I spent whole day yesterday experimenting with BCM47094 and NAND
controller to understand your case better.

As crazy as it sounds, my NAND controller working in BCH4 mode is
reading flash data programmed using BCH8 perfectly fine! I was testing
& verifying that behavior multiple times for hours. It really works.

I noticed that on my BCM47094 board with CFE working in BCH8:
1) Flashing firmware with CFE results in using BCH8 (expected)
2) Linux with NAND controller in BCH4 can read flash data (unexpected!)
3) Writing flash data results in using BCH4

Above write test proves that NAND controller is really setup into BCH4
mode correctly. How is it possible it reads flash data programmed
using BCH8 is out of my imagination.


Long story short I believe your patch is wrong. DTS should describe
hardware and by default this board uses BCH8 (and so the bootloader).
Current DTS is correct.


As it happens your patch doesn't break anything directly because of
unexpected NAND controller behavior. It's just a matter of "luck"
though due to some weird hardware behavior.

-- 
Rafa?
