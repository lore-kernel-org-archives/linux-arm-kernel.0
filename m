From: matthew_minter@xyratex.com (Matthew Minter)
Date: Wed, 6 Nov 2013 14:06:24 +0000
Subject: Delivery Status Notification (Failure)
In-Reply-To: <047d7b86e7727b700204ea828c1d@google.com>
References: <CAFJTrDsaq-NjLhcwHBuN1Q_zu-Q-yJkWLMUER1zVzc1=AFNM=Q@mail.gmail.com>
 <047d7b86e7727b700204ea828c1d@google.com>
Message-ID: <CAFJTrDvSN2uMFi5zMwSU0Xc+p26VRw97YmLhq-G_WRcmv6tq-A@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Everyone,

I am sorry for the exceedingly long delay before replying, I have had
a number of unrelated problems which have prevented me from working on
this issue.

The version of u-boot which caused this issue was Marvell's Q2-2013
release. I used this with a 3.12 rc1 and a 3.12 rc3 kernel, both
receiving the errors I have mentioned above. I have ensured my low
level debugging configuration is correct, it is indeed mapped
correctly to the new register range and I do not believe this to be
the problem, particularly as it crashes well after the early printk
has begun giving output.

Unfortunately I cannot find the log file from the kernel at this stage
as it appears to have been filled and overwritten, I however did look
into this further and Marvell have (since when I raised the problem)
given me a patched u-boot which is no longer causing the issue (the
patch seems to be dated mid October 2013), unfortunately I cant post
the change log of the patch but it does appear the problem was caused
by a buggy u-boot release (or at least that it is fixed with the
patched version). I have since tested the new version with kernels
3.12 rc3 to 3.12 rc6 and none of them have any issues with booting.
Here is a full diff of the change I made to the device tree file (dont
mind the bogus timestamps)

--- arch/arm/boot/dts/armada-xp-gp.dts.old    2013-11-06
13:39:17.440000000 +0000
+++ arch/arm/boot/dts/armada-xp-gp.dts    2013-11-05 17:32:16.160001348 +0000
@@ -39,7 +39,7 @@
     };

     soc {
-        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
+        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000

               MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
               MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;

I think the issue therefore may not be a kernel issue after all and
should likely not be worried about. However on a related matter, I had
thought the kernel was supposed to have some kind of detection for the
register location using cp15? Why does the device tree describe the
register address staticly if this is the case?

Ultimately I think the specific errors I was getting (along with the
exact error being variable dependant on seemingly random factors) made
the specific errors a red herring and the problem was due to a faulty
initialisation by the bootloader. However if there is any other
information I can give or if anyone is interested I may be able to
find out more.

Best regards,
Matthew

On 6 November 2013 13:58, Mail Delivery Subsystem
<mailer-daemon@googlemail.com> wrote:
> Delivery to the following recipient failed permanently:
>
>      linux-arm-kernel at lists.infradead.org
>
> Technical details of permanent failure:
> Google tried to deliver your message, but it was rejected by the server for the recipient domain lists.infradead.org by merlin.infradead.org. [205.233.59.134].
>
> The error that the other server returned was:
> 550-Mailing lists do not accept HTML mail. See
> 550 http://david.woodhou.se/email.html
>
> ----- Original message -----
>
> X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
>         d=1e100.net; s=20130820;
>         h=x-gm-message-state:mime-version:in-reply-to:references:date
>          :message-id:subject:from:to:content-type;
>         bh=7ZxkcjMOgG2fPbDIq0WtE/eu/1H9O3KEeGtX4g0cEwc=;
>         b=dxwtJYHC5DNmtLbRqHF3nOw7L6jPlkQeYBV0Lu3X+NUD50WrnLJq4LaaA3Xc8p9ZdE
>          iq9axkL33lyu7+YL41iDM+uyXrVXdGfSevUw7VKm3LemgC6aVUM8Cjv9LTJIanncySaJ
>          nlgy2K1dGUEfQffHqC3hoZp5RqCudW4JtRBGCEkkwcRZPxD4ygh09XGeJlXkciZ5xwou
>          7bBwPY1TrEqsnbMvZNW59OS6NMjePvRi4NlSSG62w7p1sbes4NnTZrzCWYKNEg0JSmdc
>          jpkoy04IypB54+95FyGFZzUOu3V3XKeTC2AvU9I/o8imwCVxcaW8hwaQ25er+ETEgWU9
>          DK9Q==
> X-Gm-Message-State: ALoCoQmHzfdGMpqQ7DTvrzz4hpObpdipXgf2lGK+1cbRTSUyoaRE9sz7r32vzDU4Dsf3MuyWtioe7lnz0x3W8va3BaN2qtW/4g1vpApNOlp2FOxktOlZoZfYLfTcDRAkcCTofZ7ZrhLE
> MIME-Version: 1.0
> X-Received: by 10.66.159.234 with SMTP id xf10mr3984291pab.139.1383746298406;
>  Wed, 06 Nov 2013 05:58:18 -0800 (PST)
> Received: by 10.68.193.138 with HTTP; Wed, 6 Nov 2013 05:58:18 -0800 (PST)
> In-Reply-To: <20131022181141.3f567273@skate>
> References: <CAFJTrDtznkpwi76yyEKYvjuo+XV34ky9AOe8Qfa5wm-uHDJT6A@mail.gmail.com>
>         <20131021174339.GA27284@localhost>
>         <20131021184219.GA24520@titan.lakedaemon.net>
>         <20131022152950.40171b36@skate>
>         <CAFJTrDtKw0ANh55Y6xQtFzGtvmZOJ-ZC6cFuKV62L0tmmhT3uA@mail.gmail.com>
>         <20131022181141.3f567273@skate>
> Date: Wed, 6 Nov 2013 13:58:18 +0000
> Message-ID: <CAFJTrDsaq-NjLhcwHBuN1Q_zu-Q-yJkWLMUER1zVzc1=AFNM=Q@mail.gmail.com>
> Subject: Re: Armada XP Internal registers
> From: Matthew Minter <matthew_minter@xyratex.com>
> To: Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
>         Jason Cooper <jason@lakedaemon.net>, Ezequiel Garcia <ezequiel.garcia@free-electrons.com>,
>         linux-arm-kernel at lists.infradead.org
> Content-Type: multipart/alternative; boundary=047d7b86e7729390ac04ea828a5b
>
> Hi Everyone,
>
> I am sorry for the exceedingly long delay before replying, I have had a
> number of unrelated problems which have prevented me from working on this
> issue.
>
> The version of u-boot which caused this issue was Marvell's Q2-2013
> release. I used this with a 3.12 rc1 and a 3.12 rc3 kernel, both receiving
> the errors I have mentioned above. I have ensured my low level debugging
> configuration is correct, it is indeed mapped correctly to the new register
> range and I do not believe this to be the problem, particularly as it
> crashes well after the early printk has begun giving output.
>
> Unfortunately I cannot find the log file from the kernel at this stage as
> it appears to have been filled and overwritten, I however did look into
> this further and Marvell have (since when I raised the problem) given me a
> patched u-boot which is no longer causing the issue (the patch seems to be
> dated mid October 2013), unfortunately I cant post the change log of the
> patch but it does appear the problem was caused by a buggy u-boot release
> (or at least that it is fixed with the patched version). I have since
> tested the new version with kernels 3.12 rc3 to 3.12 rc6 and none of them
> have any issues with booting. Here is a full diff of the change I made to
> the device tree file (dont mind the bogus timestamps)
>
> --- arch/arm/boot/dts/armada-xp-gp.dts.old    2013-11-06 13:39:17.440000000
> +0000
> +++ arch/arm/boot/dts/armada-xp-gp.dts    2013-11-05 17:32:16.160001348
> +0000
> @@ -39,7 +39,7 @@
>      };
>
>      soc {
> -        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xd0000000 0x100000
> +        ranges = <MBUS_ID(0xf0, 0x01) 0 0 0xf1000000 0x100000
>                MBUS_ID(0x01, 0x1d) 0 0 0xfff00000 0x100000
>                MBUS_ID(0x01, 0x2f) 0 0 0xf0000000 0x1000000>;
>
> I think the issue therefore may not be a kernel issue after all and should
> likely not be worried about. However on a related matter, I had thought the
> kernel was supposed to have some kind of detection for the register
>
> ----- Message truncated -----
>

-- 


------------------------------
For additional information including the registered office and the treatment of Xyratex confidential information please visit www.xyratex.com

------------------------------
