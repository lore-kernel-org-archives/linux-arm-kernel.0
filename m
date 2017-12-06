From: guillaume.tucker@collabora.com (Guillaume Tucker)
Date: Wed, 6 Dec 2017 09:22:04 +0000
Subject: [PATCH 1/2] drm/nouveau/bar/gf100: fix hang when calling ->fini()
 before ->init()
In-Reply-To: <CABDvA=krahNw3q+qpEPbbv8Y9fvX4jXc_B54qafwtgFyWpqKWg@mail.gmail.com>
References: <be610a7596ad8fee7da092161888c532c2eb2908.1512411775.git.guillaume.tucker@collabora.com>
 <6db622ac-319d-c640-91ab-9248e528b69b@nvidia.com>
 <CABDvA=krahNw3q+qpEPbbv8Y9fvX4jXc_B54qafwtgFyWpqKWg@mail.gmail.com>
Message-ID: <d5b6a012-52c4-dce3-1cc6-3041558e808b@collabora.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 05/12/17 18:32, Ben Skeggs wrote:
> On Wed, Dec 6, 2017 at 12:30 AM, Jon Hunter <jonathanh@nvidia.com> wrote:
>
>>
>> On 04/12/17 18:37, Guillaume Tucker wrote:
>>> If the firmware fails to load then ->fini() will be called before the
>>> device has been initialised, causing the kernel to hang while trying
>>> to write to a register.  Add a test in ->fini() to avoid this issue.
>>>
>>> This fixes a kernel hang on tegra124.
>>>
>>> Fixes: b17de35a2ebbe ("drm/nouveau/bar: implement bar1 teardown")
>>> Signed-off-by: Guillaume Tucker <guillaume.tucker@collabora.com>
>>> CC: Ben Skeggs <bskeggs@redhat.com>
>>> ---
>>>  drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c | 7 +++++--
>>>  1 file changed, 5 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
>> b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
>>> index a3ba7f50198b..95e2aba64aad 100644
>>> --- a/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
>>> +++ b/drivers/gpu/drm/nouveau/nvkm/subdev/bar/gf100.c
>>> @@ -43,9 +43,12 @@ gf100_bar_bar1_wait(struct nvkm_bar *base)
>>>  }
>>>
>>>  void
>>> -gf100_bar_bar1_fini(struct nvkm_bar *bar)
>>> +gf100_bar_bar1_fini(struct nvkm_bar *base)
>>>  {
>>> -     nvkm_mask(bar->subdev.device, 0x001704, 0x80000000, 0x00000000);
>>> +     struct nvkm_device *device = base->subdev.device;
>>> +
>>> +     if (base->subdev.oneinit)
>>> +             nvkm_mask(device, 0x001704, 0x80000000, 0x00000000);
>>>  }
>>>
>>>  void
>>
>> I have tested this and it works for me. Thanks for fixing this! Would be
>> good to get Ben's ACK, but you can have my ...
>>
> I'd love to get a good explanation as to why it hangs without this change,
> as, on the surface, it's not immediately obvious as to why it's hanging.

To be fair I'm not entirely sure either why this causes a hang, I
haven't read the TRM...  The iomem has been mapped at this point,
so accessing the register should work.  One clue is when you look
at _bar1_init(), the 0x1704 register is initialised with
some (device instance?) memory address.  So it's possible that
the hardware does something special when you set this to 0 as in
_bar1_fini(), which may fail in particular if it was previously
not initialised with a valid address.

This is merely guesswork, would be interested to find out the
real explanation though.

>> Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!

Guillaume
