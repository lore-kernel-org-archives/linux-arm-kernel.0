From: maxime.ripard@free-electrons.com (Maxime Ripard)
Date: Mon, 30 May 2016 20:45:32 +0200
Subject: [PATCH v2] clk: sunxi: predivider handling for factors clock
In-Reply-To: <CAEzqOZvnKKNs_sXUJrwTykA5mzwKMg+HpaFcKgBTFr+utT4qQg@mail.gmail.com>
References: <1461084466-20889-1-git-send-email-vishnupatekar0510@gmail.com>
 <1461084466-20889-2-git-send-email-vishnupatekar0510@gmail.com>
 <20160502111337.GR17159@lukather>
 <CAEzqOZvnKKNs_sXUJrwTykA5mzwKMg+HpaFcKgBTFr+utT4qQg@mail.gmail.com>
Message-ID: <20160530184532.GD4908@lukather>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Vishnu,

On Mon, May 16, 2016 at 07:28:42AM +0800, Vishnu Patekar wrote:
> > > @@ -307,7 +305,7 @@ static void sun6i_get_ahb1_factors(struct factors_request *req)
> > >       div = DIV_ROUND_UP(req->parent_rate, req->rate);
> > >
> > >       /* calculate pre-divider if parent is pll6 */
> > > -     if (req->parent_index == SUN6I_AHB1_PARENT_PLL6) {
> > > +     if (req->prediv_width) {
> > >               if (div < 4)
> > >                       calcp = 0;
> > >               else if (div / 2 < 4)
> >
> > You should also remove that code from that function. Now that the core
> > can tell the pre-divider configuration, it can adjust the parent rate
> > so that you don't have to care anymore.
>
> We still need to get m factor when it's called from set_rate and
> determine_rate.
> 
> Sorry, I did not your "that code from that function" meaning. I assumed
> you're talking about m factor in sun6i_get_ahb1_factors.

Sorry for the late answer.

I don't know if you've seen it, but I have been working on a new clock
framework.

I went over all the A83T clocks, and most of them could be
covered. The issue only lies in the PLLs and their additional 1-bit
dividers.

If we just choos to ignore (one of) them, it should be pretty trivial
to implement with the current clock classes we have.

There's also the current assumption that there's a single parent that
has a pre-divider, but that can easily be fixed by setting up an
array.

Maxime

-- 
Maxime Ripard, Free Electrons
Embedded Linux, Kernel and Android engineering
http://free-electrons.com
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 819 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20160530/d2c5751b/attachment.sig>
