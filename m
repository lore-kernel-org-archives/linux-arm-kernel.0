From: manabian@gmail.com (Joachim Eastwood)
Date: Wed, 14 Oct 2015 19:23:09 +0200
Subject: [PATCH 2/5] arm: dts: lpc32xx: fix improper usage of ranges
 property
In-Reply-To: <7163229.YtgKU9kxxJ@wuerfel>
References: <1444694045-22000-1-git-send-email-vz@mleia.com>
 <5493797.P10V9v7QAu@wuerfel> <561D902D.7020503@mleia.com>
 <7163229.YtgKU9kxxJ@wuerfel>
Message-ID: <CAGhQ9VzKrsAYy=xwEZPD80jaTxmqR5MJj7fXeFTK-A2JnJXPqA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Arnd,

On 14 October 2015 at 15:52, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday 14 October 2015 02:13:49 Vladimir Zapolskiy wrote:
>> Ok, practically it should work for my purposes, but the change must be
>> done along with added EMC device node description.
>>
>> I'm not so confident that it is correct to add description of static
>> memory banks to ahb node though, please give me a short confirmation,
>
> The DT should reflect whichever memory ranges are accessible
> on the bus. I've looked up the memory map in the data sheet, and
> I think a reasonable representation would be
>
> /ahb {
>         ranges = <0x20000000 0x20000000 0x10000000>, /* AHB port 5 */
>                  <0x30000000 0x30000000 0x10000000>, /* AHB port 6 */
>                  <0x40000000 0x40000000 0x10000000>, /* AHB port 7 */
>                  <0x80000000 0x80000000 0x40000000>, /* EMC DYCS0/1 */
>                  <0xE0000000 0xE0000000 0x04000000>; /* EMC CS0-3 */
>
>         apb {
>                 ranges = <0x20080000 0x20080000 0x00020000>;
>         };
>
> };
>
> alternatively, each AHB port could be a separate node, with a
> more direct translation like
>
> /ahb5 {
>         ranges = <0 0x20000000 0x10000000>;
>
>         apb {
>                 ranges = <0 0x80000 0x20000>;
>         };
> };
> /ahb6 {
>         ranges = <0 0x30000000 0x10000000>,           /* AHB registers */
>                  <0x80000000 0x80000000 0x40000000>, /* EMC DYCS0/1 */
>                  <0xE0000000 0xE0000000 0x04000000>; /* EMC CS0-3 */
>
>         memory-controller at 1080000 {
>                 reg = <0x1080000 0x10000>;
>         };
> };

Sorry for hijacking the thread, but I have related question to this.

What is the advantage of using a hierarchical bus structure in dt?
I thought the recommendation, at least for new device trees, was to
keep it flat under a "soc"-node.

If doesn't offer any advantages why not remove instead of adding the
ranges property which seems to grow a bit complex now?
Of course removing it would create a lot of churn because of the
re-indentation but at least the end result would be simpler.


regards,
Joachim Eastwood
