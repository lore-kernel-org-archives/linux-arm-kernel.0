From: jcm@jonmasters.org (Jon Masters)
Date: Wed, 25 Nov 2015 00:45:13 -0500
Subject: [PATCH] arm64: restore bogomips information in /proc/cpuinfo
In-Reply-To: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
References: <1447870505-19319-1-git-send-email-yang.shi@linaro.org>
Message-ID: <56554AE9.5070901@jonmasters.org>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 11/18/15, 1:15 PM, Yang Shi wrote:

> As what Pavel Machek reported [1], some userspace applications depend on
> bogomips showed by /proc/cpuinfo.
>
> Although there is much less legacy impact on aarch64 than arm, but it does
> break libvirt.
>
> Basically, this patch reverts commit 326b16db9f69fd0d279be873c6c00f88c0a4aad5
> ("arm64: delay: don't bother reporting bogomips in /proc/cpuinfo"), but with
> some tweak due to context change.

On a total tangent, it would be ideal to (eventually) have something 
reported in /proc/cpuinfo or dmesg during boot that does "accurately" 
map back to the underlying core frequency (as opposed to the generic 
timer frequency). I have seen almost countless silly situations in the 
industry (external to my own organization) in which someone has taken a 
$VENDOR_X reference system that they're not supposed to run benchmarks 
on, and they've done it anyway. But usually on some silicon that's 
clocked multiples under what production would be. Then silly rumors 
about performance get around because nobody can do simple arithmetic and 
notice that they ought to have at least divided by some factor.

Whether we do this through one of the platform tables or otherwise 
(multiple vendor EFI firmwares are being modified to make this much more 
glaringly obvious in the GUI view of system configuration so that when 
they do things they shouldn't, it's at least in the output) we should 
ultimately make sure that idiots at least have a fighting chance of 
noticing that they're actually running at 1GHz, and not 2 or 3GHz.

Jon.
