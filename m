From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Sun, 20 Jul 2014 23:33:22 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20140721054405.GK21834@1wt.eu>
References: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
 <CAB8gEUv52mjpAuYRKhv8_VuAwt9Uog5eD2jn45gnyqcd+cXv8g@mail.gmail.com>
 <20140708102142.0f7fe796@free-electrons.com>
 <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
 <20140715142431.4eccbcd6@free-electrons.com>
 <20140715124333.GF12333@1wt.eu>
 <CAB8gEUt08QVpgW0fs18tNnCkCw36SD6hxgL8O6p6+oOtX0-yJQ@mail.gmail.com>
 <20140717081527.GJ14723@1wt.eu>
 <CAB8gEUsLmuDkTzGsq8fVs9dZ90d82Brw2cAPBOnobUTcSgQabA@mail.gmail.com>
 <CAB8gEUvwPJUhDN-=tugTyKe93SdNwqNaGtKMF1DRCb8ZNncmmg@mail.gmail.com>
 <20140721054405.GK21834@1wt.eu>
Message-ID: <CAB8gEUsK9c3YMpAABifNAWU7zec2ePztSqS4KAYtiT7Sbhadvg@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Willy,
Good day.

> OK. For information, the mirabox uses a 88F6707 and a 88E1510 for
the phy.
> So it's very close to what you have.
Noted.

> As you said that you both applied cd71e2 and reverted 4f3a4f, could you
please confirm that with cd71 applied only it was not enough?
Yes.
If mvneta.c used is the v3.13.9 + cd71e2, issue still occurs.
If mvneta.c used is the v3.13.9 + cd71e2 - 4f3a4f, issue does not occur anymore.

> I'm finding it really strange, because as you use the same CPU as the
mirabox,
> I'm seeing no reason why the IRQ wouldn't work, and since
you're using a slightly different phy from us, the first patch which
changes the the RGMII configuration (cd71e2) would be a more likely
candidate.

Okay. First, I'll check if the interrupts are working by checking
this, as you suggested:
<snip>
Checking /proc/interrupts when you're sending some traffic should show
that the IRQ is increasing from time to time.
<snip>
I'll inform you the results within the next 2-3 days.

> First you're not using a mainline kernel which means that you'll always
be bothered.
> Second, removing support for the Tx IRQ means that your Tx traffic can become very slow (typically 134 Mbps instead of 987 for unidirectional traffic), which can be a problem if your board is used as a router for example.
> If you're building a NAS, you'll have less impact.
We'll be using it as a router, thus, it would really be a problem for us.
Will check possibilities of shifting to v3.14+ with our customer -
especially if we found problems in ethernet performance as you
mentioned.
Any recommendations on which version to use, specifically?

> Third, considering that other boards work without applying these changes, it might be possible that there's an issue on your board, and maybe detecting it early would allow you to fix it for all future batches, and maybe only apply these patches for the few very first ones.
Acknowledged.
Once we verified that indeed, the performance was slower (or
interrupts were not increasing) - we will inform our hardware team and
have them investigate this issue further for possible hardware bugs.

Thanks a lot for the help again, I'll let you know as soon as I have more info.

Regards,
Maggie Roxas

On Sun, Jul 20, 2014 at 10:44 PM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Maggie,
>
> On Sun, Jul 20, 2014 at 07:45:13PM -0700, Maggie Mae Roxas wrote:
>> Hi Willy,
>> Good day.
>>
>> BTW, here are some answers to your questions.
>>
>> > In fact I don't know if you're running your own board or a "standard"
>> one (a mirabox or any NAS board).
>> We are using a "customized" one, not a "standard" one.
>> We based the design on Armada 370 RD Evaluation Board, but we used
>> Marvell 88E1512 as Ethernet PHY and Marvell 88F6707 as processor
>> instead of the ones in the Armada 370 RD (I think it uses Marvell
>> 88E1310 as Ethernet PHY and Marvell 88F6W11 as processor).
>
> OK. For information, the mirabox uses a 88F6707 and a 88E1510 for
> the phy. So it's very close to what you have.
>
>> > Maggie, do you know if it is possible that for any reason your board
>> would not deliver an IRQ on Tx completion ? That could explain things.
>> > You can easily test reverting commit 4f3a4f701b just in case.
>> > If that's the case, then the next step will be to figure out how it is possible
>> that IRQs are disabled!
>> After reverting 4f3a4f701b, as I reported, issue does not happen anymore.
>
> As you said that you both applied cd71e2 and reverted 4f3a4f, could you
> please confirm that with cd71 applied only it was not enough ? I'm
> finding it really strange, because as you use the same CPU as the
> mirabox, I'm seeing no reason why the IRQ wouldn't work, and since
> you're using a slightly different phy from us, the first patch which
> changes the the RGMII configuration (cd71e2) would be a more likely
> candidate.
>
>> Please let me know how to "figure out how it is possible that IRQs are
>> disabled".
>
> Checking /proc/interrupts when you're sending some traffic should show
> that the IRQ is increasing from time to time.
>
>> Also, what is the impact if I use this combination?
>
> First you're not using a mainline kernel which means that you'll always
> be bothered. Second, removing support for the Tx IRQ means that your
> Tx traffic can become very slow (typically 134 Mbps instead of 987 for
> unidirectional traffic), which can be a problem if your board is used
> as a router for example. If you're building a NAS, you'll have less
> impact. Third, considering that other boards work without applying
> these changes, it might be possible that there's an issue on your
> board, and maybe detecting it early would allow you to fix it for all
> future batches, and maybe only apply these patches for the few very
> first ones.
>
> Regards,
> Willy
>
