From: dianders@chromium.org (Doug Anderson)
Date: Mon, 8 Dec 2014 10:53:44 -0800
Subject: [PATCH v3] i2c: rk3x: fix bug that cause measured high_ns doesn't
 meet I2C spec
In-Reply-To: <20141208173432.GA5732@katana>
References: <1415261514-4051-1-git-send-email-addy.ke@rock-chips.com>
 <1418007589-3688-1-git-send-email-addy.ke@rock-chips.com>
 <20141208085202.GA13486@pengutronix.de>
 <CAD=FV=V=PDPiDhDmd+j8ePsF43EvuFP-LxKgMKo7ZRBzSMyOJA@mail.gmail.com>
 <20141208173432.GA5732@katana>
Message-ID: <CAD=FV=WQypHthEDPGUqVX3kzfFBSdj4H+_QY_=WYA3R77H+WiQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

On Mon, Dec 8, 2014 at 9:34 AM, Wolfram Sang <wsa@the-dreams.de> wrote:
>
>> > There are different capitalisation of i2c in the patch and the commit log. I
>> > don't know what Wolfram prefers here, but using the same spelling
>> > everywhere would be nice.
>>
>> Can you please point out?  IIRC you should always capitalize I2C in
>> prose (descriptions, comments, documentation, etc).  However when used
>> in places which specific capitalization standards it should be
>> lowercase.  That means file names, directory names, device tree
>> property names, etc should be lower case.
>
> This is what I prefer, too. However, I am not too strict about it.
> I mean, both are readable.

Glad my understanding is OK.  :)

>
>> >> +     /* Read rise and fall ns; if not there use the default max from spec */
>> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-rising-time-ns",
>> >> +                              &i2c->rise_ns)) {
>> >> +             if (i2c->scl_frequency <= 100000)
>> >> +                     i2c->rise_ns = 1000;
>> >> +             else
>> >> +                     i2c->rise_ns = 300;
>> >> +     }
>> >> +     if (of_property_read_u32(pdev->dev.of_node, "i2c-scl-falling-time-ns",
>> >> +                              &i2c->fall_ns))
>> >> +             i2c->fall_ns = 300;
>> >> +
>> > I don't know if other drivers do the same (I assume they should). If so,
>> > moving this logic into the core would be nice. I guess this can still be
>> > done later.
>
> Let's leave that for later. If we do it, we should start with bus speed
> setting first, probably.

OK, great.


So just to summarize for Addy, I think you're being asked to spin one more time.

1. Update the patch description as per Uwe.  Fix other typos pointed out by him.

2. Since you're spinning anyway, adjust "i2c" capitalization to "I2C".

3. If you agree with Uwe, rename spec_max_data_hold_ns to
spec_data_valid_ns.  If not, we should debate in a followup patch.

4. If you think spec_data_hold_buffer_ns could be better represented
in another way (should this be i2c-sda-falling-time-ns"?), please do
so.  If not, we should debate in a followup patch.

-Doug
