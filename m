From: olof@lixom.net (Olof Johansson)
Date: Mon, 28 Oct 2013 10:46:02 -0700
Subject: [PATCH] ARM: imx: replace imx6q_restart() with mxc_restart()
In-Reply-To: <20131028081408.GF2839@S2101-09.ap.freescale.net>
References: <1381050370-3301-1-git-send-email-shawn.guo@linaro.org>
 <CAOesGMjB6D3owftDUfmMbVNx8_EtY9-RXoGbS3Rmry4FQhSfZQ@mail.gmail.com>
 <20131028081408.GF2839@S2101-09.ap.freescale.net>
Message-ID: <CAOesGMijji0JBJqne_j8kPedYFF82U7fh7KS92PV1hJztJXE6w@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Mon, Oct 28, 2013 at 1:14 AM, Shawn Guo <shawn.guo@linaro.org> wrote:
> On Sun, Oct 27, 2013 at 10:17:19PM -0700, Olof Johansson wrote:
>> > @@ -52,6 +55,8 @@ void mxc_restart(enum reboot_mode mode, const char *cmd)
>> >
>> >         /* Assert SRS signal */
>> >         __raw_writew(wcr_enable, wdog_base);
>> > +       /* write twice to ensure the request will not get ignored */
>> > +       __raw_writew(wcr_enable, wdog_base);
>> >
>> >         /* wait for reset to assert... */
>> >         mdelay(500);
>>
>> "will not get ignored" seems like an odd choice of words here. What's
>> the actual purpose of the double write? Does some versions of the
>> hardware ignore the first write, or is it that you need to make sure
>> that the write has reached the hardware block for some other reason?
>
> Oh, you got it.  We're hiding an imx6q hardware defect here.  Most of
> the time, a single write will just work on imx6q, but there is a chance
> that the first write could be missed by WDOG SRC sampling logic.  I
> chose to add it unconditionally here to save a target check since
> a redundant write shouldn't be so harmful for other targets.

Ok, sounds good.

>> I came across this patch in your pull request -- I will merge the
>> branch anyway but I'd like to get the above answered and fixed up
>> later for clarification if needed.
>
> When the code was originally written in imx6q_restart(), there was no
> formal errata for this defect.  But now there is, see ERR004346 (WDOG:
> WDOG SRS bit requires to be written twice) in Chip Errata for i.MX6Q
> below.
>
> http://cache.freescale.com/files/32bit/doc/errata/IMX6DQCE.pdf?fpsp=1
>
> I will send a follow-up patch to add necessary clarification.

Great. Just a quick reference to the errata should be sufficient.

By the way, the errata document says that you must write it twice
within one 32kHz clock period. You might want to write it three times
just in case two of them happen to straddle that period by pure bad
luck. I'm guessing it's rare enough that you haven't been able to
reproduce it though.


-Olof
