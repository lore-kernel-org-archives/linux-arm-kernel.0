From: m.smarduch@samsung.com (Mario Smarduch)
Date: Wed, 17 Sep 2014 12:19:50 -0700
Subject: [PATCH 1/2] ARM: kvm: define PAGE_S2_DEVICE as read-only by
 default
In-Reply-To: <CAKv+Gu-MAkzFtrFk19mYB=jQyLsFLY+k3Ly=eZQ=3hWSALLRPw@mail.gmail.com>
References: <1410603462-28900-1-git-send-email-ard.biesheuvel@linaro.org>
 <bcbc1c52f9e1eeb24f0bd1956236f0a3@www.loen.fr>
 <CAKv+Gu8J8o2=CS9tGVbkavHep6gNwSSegZ0fxqsVE2AVDVzdpA@mail.gmail.com>
 <20140913170638.GA3348@lvm>
 <CAKv+Gu93FkRWXd96gKdN+OCrUgjF0sXWL4ohishVWAO-XeR9Ww@mail.gmail.com>
 <fdc415c79e617d4e9102acc12a4c0d65@www.loen.fr>
 <CAKv+Gu-kce_1cg2fgj5Qj_kRMtzzHctofZ108531-UrcFLZAog@mail.gmail.com>
 <CAKv+Gu-MAkzFtrFk19mYB=jQyLsFLY+k3Ly=eZQ=3hWSALLRPw@mail.gmail.com>
Message-ID: <5419DED6.6050307@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 09/14/2014 03:57 PM, Ard Biesheuvel wrote:

> 
> Never mind. I read the whole thread this time.
> 
> So, in summary, there is a concern that a malicious guest may request
> a cachable mapping for a device range, in an attempt to manipulate the
> VGIC or other device memory of another VM.
> I think that concern only applies to writable mappings, so perhaps we
> should just change
> 
> if (kvm_is_mmio_pfn(pfn))
> 
> to
> 
> if (kvm_is_mmio_pfn(pfn) && writable)
Hi Ard,

What if the device passed through is read-only like maybe IPMI
sensors.

> 
> and be done with it (which is coincidentally the very first naive fix
> I suggested for the issue i was seeing)
> That way, we never map read-only MMIO regions writable, and rely on
> the MT_DEVICE trumps MT_NORMAL rule to ensure the guest reads to those
> regions are uncached.
> (Wouldn't hurt to add a comment to explain it, I suppose)
> 
