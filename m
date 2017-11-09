From: jonathanh@nvidia.com (Jon Hunter)
Date: Thu, 9 Nov 2017 21:45:07 +0000
Subject: next/master boot: 273 boots: 63 failed, 209 passed with 1
 untried/unknown (next-20171106)
In-Reply-To: <bfed6e80-44a7-6e96-c6a6-bc9793a1937a@collabora.com>
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
Message-ID: <2038e32a-de4a-a683-462e-555e991a2111@nvidia.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org


On 09/11/17 19:03, Guillaume Tucker wrote:
...

> Alright, so here's all the results I got all based on
> next-20171109 and running on tegra124-nyan-big:
> 
> ? * plain multi_v7_defconfig, passes:
> ??? https://lava.collabora.co.uk/scheduler/job/981295
> 
> ? * CONFIG_MODULES disabled, fails:
> ??? https://lava.collabora.co.uk/scheduler/job/981342
> 
> ? * CONFIG_MODULES and CONFIG_DRM_NOUVEAU disabled, also fails:
> ??? https://lava.collabora.co.uk/scheduler/job/981343

This is the crash in the EC driver that I mentioned before. You need to
add the fix for the EC driver to avoid this BUG_ON.

I was able to bisect this manually dancing around the various bugs and
it points to this commit ...

commit 7313cfa4f6e30384fa04083698d1e865cf812a6a
Author: Ben Skeggs <bskeggs@redhat.com>
Date:   Wed Nov 1 03:56:19 2017 +1000

    drm/nouveau/bar: move bar1 initialisation into its own function


Unfortunately, I cannot revert cleanly on top of next-20171109 and so I
cannot confirm.

Ben, we are seeing a hang on Tegra when booting with CONFIG_DRM_NOUVEAU
enabled. Apart from the above bisect result, I don't have much else to
go on at the moment. Let me know if you have any thoughts or anything to
test.

Cheers
Jon

-- 
nvpublic
