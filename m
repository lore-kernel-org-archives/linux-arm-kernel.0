From: eric@anholt.net (Eric Anholt)
Date: Fri, 02 Dec 2016 13:13:35 -0800
Subject: [PATCH 1/2] clk: bcm: Support rate change propagation on bcm2835
 clocks
In-Reply-To: <20161202205021.074fd441@bbrezillon>
References: <1480626020-20031-1-git-send-email-boris.brezillon@free-electrons.com>
 <1480626020-20031-2-git-send-email-boris.brezillon@free-electrons.com>
 <87lgvyf956.fsf@eliezer.anholt.net> <20161202205021.074fd441@bbrezillon>
Message-ID: <87y3zynif4.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Boris Brezillon <boris.brezillon@free-electrons.com> writes:

> On Fri, 02 Dec 2016 11:01:09 -0800
> Eric Anholt <eric@anholt.net> wrote:
>
>> Boris Brezillon <boris.brezillon@free-electrons.com> writes:
>> 
>> > Some peripheral clocks, like the VEC (Video EnCoder) clock need to be set
>> > to a precise rate (in our case 108MHz). With the current implementation,
>> > where peripheral clocks are not allowed to forward rate change requests
>> > to their parents, it is impossible to match this requirement unless the
>> > bootloader has configured things correctly, or a specific rate has been
>> > assigned through the DT (with the assigned-clk-rates property).
>> >
>> > Add a new field to struct bcm2835_clock_data to specify which parent
>> > clocks accept rate change propagation, and support set rate propagation
>> > in bcm2835_clock_determine_rate().
>> >
>> > Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>  
>> 
>> A possible simplification would be to limit VEC to only PLLH_AUX, since
>> that was how the HW designers intended it to be used.  Then you could
>> just have SET_RATE_PARENT flag, rather than the bitfield.
>> 
>
> I can rework the patches to do that if you prefer.

I'm fine with the patches as is, just throwing the idea out there.

In general, I think the only automatic parent switching I've heard of
being useful in the platform is I2S's clock being able to get a
non-MASHed clock when the rate divides evenly off of something.  Other
than that, automatic parent switching seems to just get us in trouble
(we've had bugs with PLLC, and we wouldn't want any non-VEC clock to end
up on PLLH_AUX either).
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20161202/32e5bcae/attachment.sig>
