From: sboyd@codeaurora.org (Stephen Boyd)
Date: Fri, 26 Jul 2013 10:05:21 -0700
Subject: [PATCH 3/4] msm_serial: Make baud_code detection more dynamic
In-Reply-To: <CAJAp7Og1jwyAn0sGbb_1Bk5_fvBWa1AuDNsRV1b17S0Tijk9kg@mail.gmail.com>
References: <1374691051-28544-1-git-send-email-sboyd@codeaurora.org>
 <1374691051-28544-4-git-send-email-sboyd@codeaurora.org>
 <CAJAp7Og1jwyAn0sGbb_1Bk5_fvBWa1AuDNsRV1b17S0Tijk9kg@mail.gmail.com>
Message-ID: <20130726170521.GA11922@codeaurora.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 07/25, Bjorn Andersson wrote:
> On Wed, Jul 24, 2013 at 10:37 AM, Stephen Boyd <sboyd@codeaurora.org> wrote:
> > [snip]
> > +       unsigned int i, divisor;
> > +       const struct msm_baud_map *entry;
> > +       static const struct msm_baud_map table[] = {
> > +               { 1536, 0x00,  1 },
> > +               {  768, 0x11,  1 },
> > +               {  384, 0x22,  1 },
> > +               {  192, 0x33,  1 },
> > +               {   96, 0x44,  1 },
> > +               {   48, 0x55,  1 },
> > +               {   32, 0x66,  1 },
> > +               {   24, 0x77,  1 },
> > +               {   16, 0x88,  1 },
> > +               {   12, 0x99,  6 },
> > +               {    8, 0xaa,  6 },
> > +               {    6, 0xbb,  6 },
> > +               {    4, 0xcc,  6 },
> > +               {    3, 0xdd,  8 },
> > +               {    2, 0xee, 16 },
> > +               {    1, 0xff, 31 },
> > +       };
> > +
> > +       divisor = uart_get_divisor(port, baud);
> > +
> > +       for (i = 0, entry = table; i < ARRAY_SIZE(table); i++, entry++)
> > +               if (entry->divisor <= divisor)
> > +                       break;
> > +
> > +       return entry; /* Default to smallest divider */
> 
> Shouldn't matter, but you're not defaulting to the smallest divider.
> Your are defaulting to an undefined value, as `entry` will be off the
> array once i == ARRAY_SIZE().
> 

Yes because the if condition will always be true. Perhaps that's
too confusing? We could add a subtraction by 1 to make it more
obvious.

 for (i = 0; entry = table; i < ARRAY_SIZE(table) - 1; i++, entry++)
 	if (entry->divisor <= divisor)
		break;

 return entry; /* Default to smallest divider*/

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation
