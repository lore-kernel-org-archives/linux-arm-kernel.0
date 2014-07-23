From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Tue, 22 Jul 2014 19:24:35 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20140721070303.GM21834@1wt.eu>
References: <20140708102142.0f7fe796@free-electrons.com>
 <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
 <20140715142431.4eccbcd6@free-electrons.com>
 <20140715124333.GF12333@1wt.eu>
 <CAB8gEUt08QVpgW0fs18tNnCkCw36SD6hxgL8O6p6+oOtX0-yJQ@mail.gmail.com>
 <20140717081527.GJ14723@1wt.eu>
 <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
 <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
 <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
 <20140721070303.GM21834@1wt.eu>
Message-ID: <CAB8gEUtmgwfWcuoYZ-wDwHVmzHN0WyOQD9oEOGAZ_gJfbPUm-g@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,
Good day.

> OK so clearly the issue must be found.

Actually we have 2 products using Armada 370.
One has only 1 ethernet port, so it is expected to act as Client only.
The other one has 2 ethernet ports, so it's more router-like.

For the product with one port, we have checked the combination patch
and it seems like Tx IRQ is increasing so it's OK. We checked this via
/proc/interrupts and mvneta's value there changed from 500000+ to
around 900000+ after we perform a 10-iteration iperf to the server.
The throughput is also OK, we're getting around 850Mbits when we use a
1Gbit connection, which is roughly just the same as what we've been
experiencing when we're still using 3.10.x (even 3.2.x).

As for the other product with two ports, we do expect that we might be
encountering the slow performance you mentioned.
But we are not focusing on this project yet so once it's active again,
I'll let you know.

> Just thinking about something, do you have a custom boot loader ?
> It would be possible that in our case, the Tx IRQ works only because some
> obscure or undocumented bits are set by the boot loader and that in your
> case it's not pre-initialized.

We are indeed using a "custom" boot loader.
We are using Marvell u-boot 2014_T1.1 (latest QA release, I think).
We applied some patches to memory (since we have 1Gb DDR), some bits
and pieces for the interfaces we're going to support and not to
support, and of course our own environment variables.
As for the DDR memory/register patches, they came directly from our
Marvell contact.

But with what I mentioned above, I think our Tx interrupt is working...?

BTW, for both products we've designed from Armada 370 RD, we didn't
use a switch. So we removed all switch-related codes in the boot
loader.
I'm not sure if not having switch affects the behavior?

How about you? May I know what boot loader you are using?

> LTS would probably even interest your customer as it's an LTS version.
> In this case, always pick the most recent one (3.14.12 today). You may
> even be interested in 3.15.6 which contains another phy fix supposed to
> fix cd71e2, but if you're saying that it doesn't change anything for you
> I guess it will have no effet (might be worth testing for the purpose of
> helping troubleshooting though).

Thank you for this advise, we'll take note of this.
We plan to stick on using LTS from now on, as much as possible.

> OK. I still have a hard time imagining how hardware itself could prevent
> an IRQ from being delivered from a NIC which is located inside the SoC,
> but there must be an explanation somewhere :-/
I also would like to know how. :-/
But maybe it's our difference in boot loader as you speculated.

In any case, thanks a lot again for your assistance!

Regards,
Maggie Roxas

On Mon, Jul 21, 2014 at 12:03 AM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Maggie,
>
> On Sun, Jul 20, 2014 at 11:33:22PM -0700, Maggie Mae Roxas wrote:
>> > As you said that you both applied cd71e2 and reverted 4f3a4f, could you
>> please confirm that with cd71 applied only it was not enough?
>> Yes.
>> If mvneta.c used is the v3.13.9 + cd71e2, issue still occurs.
>> If mvneta.c used is the v3.13.9 + cd71e2 - 4f3a4f, issue does not occur anymore.
>
> Rather strange then.
>
>> Okay. First, I'll check if the interrupts are working by checking
>> this, as you suggested:
>> <snip>
>> Checking /proc/interrupts when you're sending some traffic should show
>> that the IRQ is increasing from time to time.
>> <snip>
>> I'll inform you the results within the next 2-3 days.
>
> OK.
>
>> We'll be using it as a router, thus, it would really be a problem for us.
>
> OK so clearly the issue must be found.
> Just thinking about something, do you have a custom boot loader ? It
> would be possible that in our case, the Tx IRQ works only because some
> obscure or undocumented bits are set by the boot loader and that in your
> case it's not pre-initialized.
>
>> Will check possibilities of shifting to v3.14+ with our customer -
>> especially if we found problems in ethernet performance as you
>> mentioned.
>> Any recommendations on which version to use, specifically?
>
> LTS would probably even interest your customer as it's an LTS version.
> In this case, always pick the most recent one (3.14.12 today). You may
> even be interested in 3.15.6 which contains another phy fix supposed to
> fix cd71e2, but if you're saying that it doesn't change anything for you
> I guess it will have no effet (might be worth testing for the purpose of
> helping troubleshooting though).
>
>> > Third, considering that other boards work without applying these changes, it might be possible that there's an issue on your board, and maybe detecting it early would allow you to fix it for all future batches, and maybe only apply these patches for the few very first ones.
>> Acknowledged.
>> Once we verified that indeed, the performance was slower (or
>> interrupts were not increasing) - we will inform our hardware team and
>> have them investigate this issue further for possible hardware bugs.
>
> OK. I still have a hard time imagining how hardware itself could prevent
> an IRQ from being delivered from a NIC which is located inside the SoC,
> but there must be an explanation somewhere :-/
>
>> Thanks a lot for the help again, I'll let you know as soon as I have more info.
>
> Thanks,
> Willy
>
