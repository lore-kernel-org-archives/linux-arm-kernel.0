From: khilman@baylibre.com (Kevin Hilman)
Date: Wed, 18 Jan 2017 11:54:20 -0800
Subject: [PATCH v4] ARM64: dts: meson-gx: Add reserved memory zone and
 usable memory range
In-Reply-To: <04113569-e342-77ff-f79a-2c9c4dc4c602@suse.de> ("Andreas
 =?utf-8?Q?F=C3=A4rber=22's?= message of "Wed, 18 Jan 2017 01:00:50 +0100")
References: <1484129414-23325-1-git-send-email-narmstrong@baylibre.com>
 <m21sw66828.fsf@baylibre.com>
 <d3a00788-c3c1-4b10-90bf-2a8bc6a138f8@suse.de>
 <7fcb8d94-840a-de2c-f43b-9123ccc65514@baylibre.com>
 <CAOesGMhYfhrd-hy=N-FYDEPmumR0=QNzn5xTLxFuKG7apo5qiw@mail.gmail.com>
 <ecb5ff50-f5d5-ffe6-0732-faf5e51906f8@baylibre.com>
 <04113569-e342-77ff-f79a-2c9c4dc4c602@suse.de>
Message-ID: <m260lc16vn.fsf@baylibre.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Andreas F?rber <afaerber@suse.de> writes:

> Hi Neil,
>
> Am 17.01.2017 um 09:21 schrieb Neil Armstrong:
>> As I finally understand, the real issue here is the usage of the "linux,useable-memory" property that
>> overrides the reg property that is changed by the bootloader to provide the "real" memory size.
>
> Yes, exactly. It assured that 0..0x01000000 was always unavailable, as
> intended, but at the same time it ignored any lowered or heightened
> upper limit coming from the bootloader side.
>
> As a rule of thumb, any nodes that have device_type set can be expected
> to be modified during boot.
>
>> As I understand the mainline U-Boot does it right, and it's a good news, and it seems uEFI need to provide
>> some specialized memory range aswell, but the vendor U-Boot versions only provide the full memory range here.
>> It seems obvious that whatever range is provided by u-boot, the first 16MiB should be reserved.
>> 
>> The stress-ng package provides this "stress" command and is used to force the kernel to map more memory
>> zones,
>
> Thanks, its binary is called stress-ng in openSUSE Tumbleweed. ;)
>
>> but I also got the issue while running a fully fledged Desktop Environment thanks to the
>> recently merged DRM driver.
>
> I'll happily test once HDMI is ready. :)
>
>> You may not be able to trigger the issue since it seems Amlogic reduces this reserved size on GXL/GXM :
>> https://github.com/khadas/linux/commit/698df2c6cfbb0d1a9359743208e83517b31da6ce
>> But it should be confirmed.
>
> Confirming no issues on three runs on meson-gxm-rbox-pro:
>
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s &
> [1] 2528
> boxer:~ # stress-ng: info:  [2528] dispatching hogs: 4 vm
> stress-ng: info:  [2528] cache allocate: default cache size: 256K
> stress-ng: info:  [2528] successful run completed in 10.07s
>
> [1]+  Done                    stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> stress-ng: info:  [2537] dispatching hogs: 4 vm
> stress-ng: info:  [2537] cache allocate: default cache size: 256K
> stress-ng: info:  [2537] successful run completed in 10.07s
> boxer:~ # stress-ng --vm 4 --vm-bytes 128M --timeout 10s
> stress-ng: info:  [2546] dispatching hogs: 4 vm
> stress-ng: info:  [2546] cache allocate: default cache size: 256K
> stress-ng: info:  [2546] successful run completed in 10.07s
> boxer:~ #
>
>> Kevin asked me initially to handle this "start of ddr" reserved zone via a reserved-memory entry, but
>> at that time it seemed a better idea to use "linux,useable-memory", but I recon it may be an error.
>> 
>> I will push a v5 with a supplementary reserved-memory entry and will postpone the boards memory size
>> fixup for a future DTS cleanup.
>> 
>> Andreas, is this ok for you ?
>
> Yes, sounds fine to me, thanks. I'll note a few more nits to consider.
>
> Kevin, I noticed that this supposedly applied patch did not show up in
> linux-next for testing - could you merge your fixes branch into for-next
> please for those of us working on new stuff?

Any fixes I have queued are always in my for-mext branch (which is
included i linux-next.)

This fix was there as well, but was removed due to objections shortly
after I added it, so it never quite made it to linux-next (or may have
for one day, I'm not sure.)

Kevin
