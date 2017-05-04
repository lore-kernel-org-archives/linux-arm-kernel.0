From: james.morse@arm.com (James Morse)
Date: Thu, 04 May 2017 16:49:07 +0100
Subject: [PATCH v3 1/3] arm64: kvm: support kvmtool to detect RAS extension
 feature
In-Reply-To: <5908A5BC.1060202@arm.com>
References: <1493530677-4919-1-git-send-email-gengdongjiu@huawei.com>
 <5908A5BC.1060202@arm.com>
Message-ID: <590B4D73.60000@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 02/05/17 16:29, James Morse wrote:
> I think we need a new API for injecting SError for SEI from Qemu/kvmtool, but it
> shouldn't be related to the RAS extensions. All v8.0 CPUs have HCR_EL2.VSE, so
> we need to know KVM supports this API.

Thinking about this some more, it is slightly more nuanced, KVM can always
provide an API to inject SError, but it can only set the VSESR if the CPU has
the RAS Extensions.

Only offering the inject-SError API call if we can also set the VSESR looks a
bit funny, but no-one has needed the no-ESR version so far.

I still don't think we should let user-space make the 'RAS Extensions means
VSESR' logical step.

So my comments on this patch become:
Don't read id registers directly, use cpus_have_cap() which handles features
that differ across CPUs or were turned off at compile time.

Please don't call this 'KVM_CAP_ARM_RAS_EXTENSION', if we are building an API to
inject SError, call it that instead.


Thanks,

James
