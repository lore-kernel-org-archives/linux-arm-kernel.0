From: julien.grall@linaro.org (Julien Grall)
Date: Tue, 03 Dec 2013 16:19:55 +0000
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <20131203160018.67542a53@alan.etchedpixels.co.uk>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
 <20131203160018.67542a53@alan.etchedpixels.co.uk>
Message-ID: <529E04AB.5060304@linaro.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 12/03/2013 04:00 PM, One Thousand Gnomes wrote:
> On Tue,  3 Dec 2013 15:40:37 +0000
> Julien Grall <julien.grall@linaro.org> wrote:
> 
>> On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
>> result on different structure from Xen and Linux repositories.
>>
>> As Linux is using __packed__ attribute, it must have a 4-bytes padding before
>> each "id" field.
>>
>> This change breaks guest block support with older kernel. IMHO, it's acceptable
>> because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
>> freezed.
> 
> How does a guest ascertain which API to use ?
> 
> How does the patch ensure new kernels on existing hypervisor versions
> don't break ?

As Ian said on the thread "xen-block: correctly define structures in
public headers" (see thread https://lkml.org/lkml/2013/12/3/155), the
ABI is not yet fixed for ARM.

> 
> What is the failure case given the alignment change seems potentially to
> produce valid but incorrect I/O requests - can it cause corruption ?

The request ID will likely be wrong, so the guest won't accept the
request. It should not corrupt the block device.

> It seems to me you should be defining
> 
> struct blkif_request_rw_v2
> 
> and using the correct version according to which API the hypervisor
> requires, not just breaking it.

This API doesn't involve the hypervisor. It's only a way to talk between
DOM0 and a guest. Without this change you will break compatibility with
other OSes.

-- 
Julien Grall
