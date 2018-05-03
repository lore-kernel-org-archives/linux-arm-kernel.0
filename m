From: linus.walleij@linaro.org (Linus Walleij)
Date: Thu, 3 May 2018 11:58:38 +0200
Subject: [PATCH 1/2 v5] drm/pl111: Support the Versatile Express
In-Reply-To: <20180503094144.GK12521@phenom.ffwll.local>
References: <20180502134719.8388-1-linus.walleij@linaro.org>
 <20180503094144.GK12521@phenom.ffwll.local>
Message-ID: <CACRpkdZK8ahaWT1Y4jQ_W6pkUZeGSFP4BT8DgtvBAKb=vX1cfA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, May 3, 2018 at 11:41 AM, Daniel Vetter <daniel@ffwll.ch> wrote:
>Me:
(...)
>> ChangeLog v4->v5:
>> - Collect Robin's Tested-by
>> - Switch to builtin_platform_driver() for the muxfpga as this
>>   file is always built as "-y" for the arch and we need to
>>   avoid module collisions with the main PL111 driver.
>> +builtin_platform_driver(vexpress_muxfpga_driver);
>
>   LD [M]  drivers/gpu/drm/pl111/pl111_drm.o
> drivers/gpu/drm/pl111/pl111_vexpress.o: In function `vexpress_muxfpga_driver_init':
> /home/daniel/linux/aarch64/drivers/gpu/drm/pl111/pl111_vexpress.c:125: multiple definition of `init_module'
> drivers/gpu/drm/pl111/pl111_drv.o:/home/daniel/linux/aarch64/drivers/gpu/drm/pl111/pl111_drv.c:427: first defined here
> make[4]: *** [scripts/Makefile.build:570: drivers/gpu/drm/pl111/pl111_drm.o] Error 1
> make[3]: *** [scripts/Makefile.build:583: drivers/gpu/drm/pl111] Error 2
> make[3]: *** Waiting for unfinished jobs....
>
> Using the default drm-misc configs.
>
> Please fix asap, and please compile-test before pushing using these
> default configs so others aren't blocked. I've disabled the pl111 driver
> in there for now, please also re-enable.

That's typical. As you see in the ChangeLog I really tried to address
exactly this. I got that build error from the zeroday build with v4,
changed it to a builtin driver and pushed, then it did not give me
the problem again.

I guess the zeroday build robot isn't using the same configs...

Hm, I will take suggestions on how to actually solve it, I guess
this is due to the initcall infrastructure only allowing one initcall
per module?

In that case I guess I should either:
- Break out the vexpress file into its own module
- Call the vexpress init hooks from the initcalls in the
  main module

I guess I will go for the latter even if it litters the driver with
more cross-calls.

Yours,
Linus Walleij
