From: linus.walleij@linaro.org (Linus Walleij)
Date: Mon, 13 Jul 2015 10:21:51 +0200
Subject: [PATCH 1/2] ARM: ux500: define serial port aliases
In-Reply-To: <CACRpkdYQFrwJqZjW-A9txA=uaZqgXchSADVhPyxd7Z+5zOmF3g@mail.gmail.com>
References: <1436520735-23692-1-git-send-email-linus.walleij@linaro.org>
 <4229513.CS60qBeWmX@wuerfel>
 <CACRpkdYQFrwJqZjW-A9txA=uaZqgXchSADVhPyxd7Z+5zOmF3g@mail.gmail.com>
Message-ID: <CACRpkdZ+_AJZhN7OmP=KXC+G0YrKuqOiWs9irjT1YFVYbab2Gw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Jul 13, 2015 at 10:16 AM, Linus Walleij
<linus.walleij@linaro.org> wrote:
> On Sun, Jul 12, 2015 at 11:02 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Friday 10 July 2015 11:32:15 Linus Walleij wrote:
>>> This enumerates the PL011 serial ports on the Ux500. This is
>>> necessary to do if we want to remove one of the serial ports,
>>> since userspace depends on console to be present on ttyAMA2
>>> and we must not break userspace.
>>>
>>> Cc: Ulf Hansson <ulf.hansson@linaro.org>
>>> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
>>> ---
>>> ChangeLog v1->v2:
>>> - Moved the alias definitions from the core SoC file
>>>   to the toplevel DTS file, as requested by Arnd.
>>>
>>>
>>
>> Do all of the boards expose all three uarts in the same order?
>
> Yes and that is the reason the patch series needs this one
> to come first.
>
> What happened historically was that userspace was hard-coded
> to use ttyAMA2 as console. So for this reason, all boards had
> to define ttyAMA0, 1, 2 in their board file (later device tree) so they
> would be enumerated in the right order, relying on the DT to
> be parsed top to bottom of course.
>
> So when I realized (in patch 2/2) that ttyAMA1 was not really
> used on some boards, it was impossible to remove it
> as userspace relied on the enumeration.
>
> However I have to remove ttyAMA1 because it is fundamentally
> wrong (the RC pin is used for MMC!). Incidentally it worked
> to steal
>
> But that breaks userspace since

Keyboard slip.

Incidentally it worked to steal the pin from ttyAMA1 even if it
was connected to the UART, but it makes things pretty
confused and we tightened the stringence of the pin control
framework and it exploded.

It turns out that ttyAMA1 was only enabled on these boards
(all boards) to get the enumeration right for userspace.

However the right way to get serial port enumeration right for
userspace is to use alias. And that is what the patch does.

Since the original code just defined all three serial ports
for all boards by them including ste-dbx500.dtsi I first made
the patch to that file, and then as you said it had to be done
on a per-toplevel file, I did it in the individual DTS files instead.

Yours,
Linus Walleij
