From: maggie.mae.roxas@gmail.com (Maggie Mae Roxas)
Date: Wed, 16 Jul 2014 22:37:47 -0700
Subject: Issue found in Armada 370: "No buffer space available" error
 during continuous ping
In-Reply-To: <20140715124333.GF12333@1wt.eu>
References: <CAB8gEUs3Z8OzOMBVqP1yN8zV1E67mGQTaxKKCw=GRuAVxJ4nGQ@mail.gmail.com>
 <CAB8gEUv52mjpAuYRKhv8_VuAwt9Uog5eD2jn45gnyqcd+cXv8g@mail.gmail.com>
 <20140708102142.0f7fe796@free-electrons.com>
 <CAB8gEUvEQdRT3Xarq_z6-KCr3T9xZ7wHvW9Termw8MAg_d-gQA@mail.gmail.com>
 <20140715142431.4eccbcd6@free-electrons.com>
 <20140715124333.GF12333@1wt.eu>
Message-ID: <CAB8gEUt08QVpgW0fs18tNnCkCw36SD6hxgL8O6p6+oOtX0-yJQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Thomas, Willy,
Good day.

First of all, thanks again for looking further into this.

> Maggie, do you know if it is possible that for any reason your board
would not deliver an IRQ on Tx completion ? That could explain things.
I'm sorrry but I'm not really sure how to check this - all I know is
that the difference in the working and not-working setup (both
software and hardware) is the mvneta.c.

> You can easily test reverting commit 4f3a4f701b just in case. If that's
the case, then the next step will be to figure out how it is possible
that IRQs are disabled!
I'll try this one, specifcally this combination:
- use 3.13.9 mvneta.c
- apply cd71e246c16b30e3f396a85943d5f596202737ba
- revert 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922

I will update you the results within today until latest tomorrow.

Thank you for your support as usual!

Regards,
Maggie Roxas

On Tue, Jul 15, 2014 at 5:43 AM, Willy Tarreau <w@1wt.eu> wrote:
> Hi Thomas,
>
> On Tue, Jul 15, 2014 at 02:24:31PM +0200, Thomas Petazzoni wrote:
>> Dear Maggie Mae Roxas,
>>
>> On Tue, 8 Jul 2014 23:35:36 -0700, Maggie Mae Roxas wrote:
>>
>> > As much as we'd like to switch to the latest v3.14.x, we need to stay
>> > at kernel v3.13.9 as that is a hard requirement of our customer (I
>> > think it's because it's the base platform for Ubuntu 14.04 FS which
>> > we'll use).
>> >
>> > So I applied your patch in our v3.13.9 as suggested:
>> > http://kernel.opensuse.org/cgit/kernel/patch/?id=cd71e246c16b30e3f396a85943d5f596202737ba
>> >
>> > Unfortunately, issue still exists after we applied it.
>> >
>> > > Basically, between 3.13.5 and 3.13.9, I introduced two patches to the
>> > network driver:
>> >
>> > Given this, we tried to replace mvneta.c of our v3.13.9 and replace it
>> > with v3.13.5's mvneta.c.
>> > Issue does not exist when we did that - but of course, we surely will
>> > miss something, so we wanted to confirm this further with you.
>> > It seems like applying cd71e246c16b30e3f396a85943d5f596202737ba in
>> > v3.13.9 is not sufficient enough..?
>> > Possibly there are v3.13.5 and v3.13.9 diff (see attached) needed
>> > apart from just cd71e246c16b30e3f396a85943d5f596202737ba?
>>
>> Hum, there are indeed more commits than I thought between 3.13.5 and
>> 3.13.9 :
>>
>> 396b229b683fdc08d8705883860ec5a1b810546a net: mvneta: fix usage as a module on RGMII configurations
>> ea64e1f33d9d627da5d38da035e5d7443276e84e net: mvneta: rename MVNETA_GMAC2_PSC_ENABLE to MVNETA_GMAC2_PCS_ENABLE
>> 4f3a4f701b59a3e4b5c8503ac3d905c0a326f922 net: mvneta: replace Tx timer with a real interrupt
>> 0ce58acf529bacd25dbe01298ff51a5c4d59a4f4 net: mvneta: add missing bit descriptions for interrupt masks and causes
>> 8c2c9b1efcc4b04b4625d0613b9e74ef17016dea net: mvneta: do not schedule in mvneta_tx_timeout
>> 92817335465090aecfde6caef9bab6923f209664 net: mvneta: use per_cpu stats to fix an SMP lock up
>> fbfbed33a5effba7dc6f33e3ed598f9bd31b0cdf net: mvneta: increase the 64-bit rx/tx stats out of the hot path
>>
>> Willy: many of the patches in this list are yours. The patch "net:
>> mvneta: fix usage as a module on RGMII configurations" is known to
>> break SGMII configurations, but even after reverting it, Maggie Mae
>> reports that mvneta in 3.13.9 doesn't work, but mvneta works on 3.13.5.
>> Do you see any missing patch on the TX rework that you did and that was
>> included betweeen 3.13.5 and 3.13.9 ?
>
> No, everything seems to be there. Additionally, my local development branch
> was actually based on the commits above as it was rebased on v3.13.9.
>
> Maggie, do you know if it is possible that for any reason your board
> would not deliver an IRQ on Tx completion ? That could explain things.
> You can easily test reverting commit 4f3a4f701b just in case. If that's
> the case, then the next step will be to figure out how it is possible
> that IRQs are disabled!
>
> Regards,
> Willy
>
