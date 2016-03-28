From: emil.l.velikov@gmail.com (Emil Velikov)
Date: Mon, 28 Mar 2016 22:35:36 +0100
Subject: [RFC PATCH v1 0/4] Add Rockchip RGA support
In-Reply-To: <13797722.SiyveTZ1bB@diego>
References: <1458552518-25527-1-git-send-email-ykk@rock-chips.com>
 <1867694.1mDULrSexE@phil>
 <CACvgo513q-Vtm2wG4Cwh4G1u0OUNVAAFmHFv-kg4fHDEy7i_eg@mail.gmail.com>
 <13797722.SiyveTZ1bB@diego>
Message-ID: <CACvgo52vL5_HQfgfnxRMzSJXYw-sWT3QozZaWswQXHr9-bwBSA@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 28 March 2016 at 19:44, Heiko St?bner <heiko@sntech.de> wrote:
> Am Montag, 28. M?rz 2016, 13:21:02 schrieb Emil Velikov:
>> On 22 March 2016 at 00:42, Heiko Stuebner <heiko@sntech.de> wrote:
>> > Hi Yakir,
>> >
>> > Am Montag, 21. M?rz 2016, 20:17:46 schrieb Yakir Yang:
>> >> On 03/21/2016 07:29 PM, Heiko St?bner wrote:
>> >> > Am Montag, 21. M?rz 2016, 17:28:38 schrieb Yakir Yang:
>> >> >> This patch set would add the RGA direct rendering based 2d graphics
>> >> >> acceleration module.
>> >> >
>> >> > very cool to see that.
>> >>
>> >> ;)
>> >>
>> >> >> This patch set is based on git repository below:
>> >> >> git://people.freedesktop.org/~airlied/linux drm-next
>> >> >> commit id: 568d7c764ae01f3706085ac8f0d8a8ac7e826bd7
>> >> >>
>> >> >> And the RGA driver is based on Exynos G2D driver, it only manages the
>> >> >> command lists received from user, so user should make the command list
>> >> >> to data and registers needed by operation to use.
>> >> >>
>> >> >> I have prepared an userspace demo application for testing:
>> >> >>    https://github.com/yakir-Yang/libdrm-rockchip
>> >> >>
>> >> >> That is a rockchip libdrm library, and I have write a simple test case
>> >> >> "rockchip_rga_test" that would test the below RGA features:
>> >> >> - solid
>> >> >> - copy
>> >> >> - rotation
>> >> >> - flip
>> >> >> - window clip
>> >> >> - dithering
>> >> >
>> >> > Did you submit your libdrm changes as well?
>> >> >
>> >> > Userspace-interfaces need to be stable so the other side must also get
>> >> > accepted - even before the kernel change if I remember correctly.
>> >>
>> >> Got it, and I just saw exynos_fimg2d already landed at mainline libdrm.
>> >> But I don't find the way to submit patches to libdrm, would you like
>> >> share some helps here ;)
>> >
>> > Looking at the libdrm sources on cgit.freedesktop.org, I did not find any
>> > specific manual on submitting patches.
>> >
>> > But looking at the dri-list archive, dri-devel at lists.freedesktop.org is
>> > the
>> > right list and looking at the libdrm history it looks like Emil Velikov
>> > <emil.l.velikov@gmail.com> seems to be doing maintenance-stuff in libdrm.
>> > And as a 3rd recipient, please also include the linux-rockchip list.
>> >
>> > @Emil, please shout if I read that wrong :-)
>>
>> You got it spot on Heiko. There are a few notes though...
>>
>> As one reuses the existing hardware/IP block, it would be better to
>> avoid copy/pasting code around.
>> Namely:
>>  - (if possible) factor out the exynos g2d kernel functionality to a
>> separate kernel module and wire up the rockhip (via dt ?) to use it
>>  - factor out the g2d specifics out of exynos_drm.h (into
>> exynos_g2d_drm.h perhaps ?) and make sure exynos_drm.h includes the
>> new header
>
> I think the IP blocks themself are quite different between Rockchip's RGA and
> Samsung's g2d and I guess the similarities are more along the lines on how
> that gets integrated into the respective drm driver and userspace.
>
In this case, the exynos_g2d_drm.h seems like a good idea. As I'm
obviously biased, it's better to check how others feel on the topic.

>
>>  - if neither of these are possible, then please ensure that the new
>> header uses correct types (see the docs [1]), use MIT/X11 license (if
>> possible) and link where upstream userspace is happy with the
>> interface (ideally more than a simple test app like libdrm)
>> These might sound like an overkill, although getting UAPI right and
>> maintaining it forever forces us to do so.
>
> As for a real-world usecase, maybe the armsoc xserver might be somewhat easy
> to use. While the core changes I did are in the core project already, I'm
> still keeping the actual Rockchip support separate [0] due to the not-yet-
> resolved create_gem ioctl.
>
> Anyway, the armsoc xserver has some exa implementation hooks were I guess it
> might be relatively easy to hook up soc-specific things.
>
Ouch the armsoc ddx... Last time I've checked it felt like a place
where everyone is doing his own thing, with no actual reviews and/or
maintainer. Iirc most/all of it's functionality was achievable with
modesetting ddx (with or without glamor) ? I take it that things have
changed and/or I misunderstood something ?

Note: The above is not meant as bashing although it hell sure looks like one.

Cheers
Emil

> [0] https://github.com/mmind/xf86-video-armsoc/tree/devel/rockchip
>
