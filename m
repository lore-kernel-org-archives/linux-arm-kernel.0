From: eric@anholt.net (Eric Anholt)
Date: Mon, 22 May 2017 15:08:52 -0700
Subject: [PATCH] drm/pl111: add ARM_AMBA dependency
In-Reply-To: <CAK8P3a3UjWM0OGVO1nNyEtrRUyFKDuBOboYVSnVLcg4MTKfFMQ@mail.gmail.com>
References: <20170522152058.3346428-1-arnd@arndb.de>
 <878tlolv1z.fsf@eliezer.anholt.net>
 <CAK8P3a3UjWM0OGVO1nNyEtrRUyFKDuBOboYVSnVLcg4MTKfFMQ@mail.gmail.com>
Message-ID: <87pof07de3.fsf@eliezer.anholt.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Arnd Bergmann <arnd@arndb.de> writes:

> On Mon, May 22, 2017 at 6:23 PM, Eric Anholt <eric@anholt.net> wrote:
>> Arnd Bergmann <arnd@arndb.de> writes:
>>
>>> The driver is written in a way to enable compile-testing without CONFIG_ARM_AMBA,
>>> but it just causes needless warnings:
>>>
>>> drivers/gpu/drm/pl111/pl111_drv.c:149:26: error: 'pl111_drm_driver' defined but not used [-Werror=unused-variable]
>>> drivers/gpu/drm/pl111/pl111_drv.c:81:12: error: 'pl111_modeset_init' defined but not used [-Werror=unused-function]
>>>
>>> This removes the #ifdef instead, and adds a dependency on ARM_AMBA to
>>> only let us build the driver when the base support is enabled.
>>>
>>> Unfortunately, this requires removing one redundant 'select ARM_AMBA'
>>> line from mach-s3c64xx to avoid a circular dependency.
>>>
>>> It might be good to allow manually enabling ARM_AMBA when COMPILE_TEST
>>> is turned on, but that should be a separate patch and may cause other
>>> build regressions.
>>
>> If I understand the Kconfig, you're effectively disabling the build on
>> COMPILE_TEST && !ARM.  I'd rather that we just fix up the warnings, so
>> that people can keep build-testing DRM drivers:
>>
>> https://patchwork.kernel.org/patch/9737857/
>
> That works too. When I tried the same, I thought it was a little too silly to
> have a file that effectively compiles into nothing.
>
> My initial approach did two things differently though:
>
> - use __maybe_unused instead of __used, since
>
> - annotate pl111_amba_driver instead of
>   pl111_drm_driver/pl111_modeset_init, and keep only
>   module_amba_driver() in the #ifdef.

Oh, yeah, we've eliminated the amba_request_regions() that used to be
why the probe had to be under the #ifdef, so your solution would get us
better coverage and simpler code.  If you could send that patch to
dri-devel today, I'll get it applied.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 832 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20170522/130d7423/attachment-0001.sig>
