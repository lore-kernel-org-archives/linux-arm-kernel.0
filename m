From: jonathanh@nvidia.com (Jon Hunter)
Date: Fri, 10 Nov 2017 11:26:28 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <1040af29-4d15-4e8a-29ab-40952523535c@nvidia.com>
References: <5a0055f1.85a8500a.98d54.a4e4@mx.google.com>
 <20171106191713.d7jqg2b6zqchythw@sirena.co.uk>
 <d8e21d87-776b-beff-62af-34e5ad1febc3@nvidia.com>
 <20171107105501.7x74gdqzhr7uulp2@sirena.org.uk>
 <a384e96c-27c7-782b-75b9-7525714f5831@collabora.com>
 <613bcd63-a215-acbe-9150-c1495f7604f6@collabora.com>
 <5740b853-4898-2ebc-f67d-0808d1b44c36@nvidia.com>
 <ab2ee0a8-6584-7436-ca1b-4f1b521279b0@collabora.com>
 <7cdfa633-d9c6-881a-ae5f-f94f7e6413ee@nvidia.com>
 <5f064e65-ee29-179b-8102-984d12d24d9d@collabora.com>
 <15792a16-6b57-a6ad-92dc-0ffaba0354db@nvidia.com>
 <1eb4e14f-4728-d4f7-95a6-0a6308760d7a@collabora.com>
 <CAK8P3a3iiSgutnHFU7PoLGQyObgyAreQOOtrDhjijoMU5wZ1Eg@mail.gmail.com>
 <18ef379f-0c23-0cbf-4228-30d5c46c690f@nvidia.com>
 <bfed6e80-44a7-6e96-c6a6-bc9793a1937a@collabora.com>
 <2038e32a-de4a-a683-462e-555e991a2111@nvidia.com>
 <64b117d3-b2ad-037a-b034-78ef1510fbb4@nvidia.com>
 <5505affd-58a5-857f-051d-5b93257e175d@redhat.com>
 <1040af29-4d15-4e8a-29ab-40952523535c@nvidia.com>
Message-ID: <5321abfb-845b-354e-f3d9-7773cfe175f4@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 10/11/17 09:18, Jon Hunter wrote:

...

> Thanks Ben. However, looking at next-20171109 this one is already in.
> So maybe the bisect is still not getting me to the current issue. When
> booting next-20171109 the last thing I see is ...
> 
> [    2.228178] nouveau 57000000.gpu: NVIDIA GK20A (0ea000a1)
> [    2.233634] nouveau 57000000.gpu: imem: using IOMMU
> [    2.238572] nouveau 57000000.gpu: Direct firmware load for nvidia/gk20a/fecs_inst.bin failed with error -2
> [    2.248295] nouveau 57000000.gpu: Direct firmware load for nouveau/nvea_fuc409c failed with error -2
> [    2.257479] nouveau 57000000.gpu: Direct firmware load for nouveau/fuc409c failed with error -2
> [    2.266189] nouveau 57000000.gpu: gr: failed to load fuc409c
> 
> So no crash. I did see the crash after the bisect, but not in top of
> tree. It appears to hang after the nouveau probe fails. Any thoughts
> on how to debug further?

So this is probably wrong, but here is a clue about what is happening. 
It appears that the error code is not being propagated from
gk20a_gr_new(). gk20a_gr_new is returning -ENODEV due to the firmware
loading failure...

342         if (gf100_gr_ctor_fw(gr, "fecs_inst", &gr->fuc409c) ||
343             gf100_gr_ctor_fw(gr, "fecs_data", &gr->fuc409d) ||
344             gf100_gr_ctor_fw(gr, "gpccs_inst", &gr->fuc41ac) ||
345             gf100_gr_ctor_fw(gr, "gpccs_data", &gr->fuc41ad))
346                 return -ENODEV;

... but this is ignored by nvkm_device_ctor() (probably for good
reason). If I make the following change the hang no longer occurs
(although I realise this is probably wrong as it has been there for
 years!) ...

diff --git a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
index e14643615698..a611615d3ce7 100644
--- a/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
+++ b/drivers/gpu/drm/nouveau/nvkm/engine/device/base.c
@@ -2869,7 +2869,7 @@ struct nvkm_engine *
                        subdev = nvkm_device_subdev(device, (s));              \
                        nvkm_subdev_del(&subdev);                              \
                        device->m = NULL;                                      \
-                       if (ret != -ENODEV) {                                  \
+                       if (ret == -ENODEV) {                                  \
                                nvdev_error(device, "%s ctor failed, %d\n",    \
                                            nvkm_subdev_name[s], ret);         \
                                goto done;                                     \

So is gk20a_gr_new() returning the wrong error code for when the
firmware load fails? 

I have no gone back to see what has change in this regard, but I
can, probably next week.

Cheers
Jon

-- 
nvpublic
