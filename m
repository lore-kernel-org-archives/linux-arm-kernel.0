From: gnomes@lxorguk.ukuu.org.uk (One Thousand Gnomes)
Date: Tue, 3 Dec 2013 16:00:18 +0000
Subject: [PATCH v2] xen/block: Correctly define structures in public
 headers on ARM32 and ARM64
In-Reply-To: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
Message-ID: <20131203160018.67542a53@alan.etchedpixels.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue,  3 Dec 2013 15:40:37 +0000
Julien Grall <julien.grall@linaro.org> wrote:

> On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
> result on different structure from Xen and Linux repositories.
> 
> As Linux is using __packed__ attribute, it must have a 4-bytes padding before
> each "id" field.
> 
> This change breaks guest block support with older kernel. IMHO, it's acceptable
> because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
> freezed.

How does a guest ascertain which API to use ?

How does the patch ensure new kernels on existing hypervisor versions
don't break ?

What is the failure case given the alignment change seems potentially to
produce valid but incorrect I/O requests - can it cause corruption ?

It seems to me you should be defining

struct blkif_request_rw_v2

and using the correct version according to which API the hypervisor
requires, not just breaking it.

Alan
