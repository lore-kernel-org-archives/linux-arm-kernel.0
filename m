From: james.morse@arm.com (James Morse)
Date: Tue, 10 Apr 2018 15:15:32 +0100
Subject: [PATCH v11 0/4] set VSESR_EL2 by user space and support
 NOTIFY_SEI notification
In-Reply-To: <1523309796-36423-1-git-send-email-gengdongjiu@huawei.com>
References: <1523309796-36423-1-git-send-email-gengdongjiu@huawei.com>
Message-ID: <d94439b6-9b9a-9bd0-ddec-3bb63ede9461@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi Dongjiu Geng,

On 09/04/18 22:36, Dongjiu Geng wrote:
> 1. Detect whether KVM can set set guest SError syndrome
> 2. Support to Set VSESR_EL2 and inject SError by user space.
> 3. Support live migration to keep SError pending state and VSESR_EL2 value.
> 4. ACPI 6.1 adds support for NOTIFY_SEI as a GHES notification mechanism, so support this
>    notification in software, KVM or kernel ARCH code call handle_guest_sei() to let ACP driver
>    to handle this notification.

Please don't post code during the merge-window, will this apply to v4.17-rc1? We
can't know until its tagged.


This series is doing two separate things, please split it into two series.

But on the ACPI front: I don't see how any OS can support your NOTIFY_SEI when
firmware is ignoring the normal world's PSTATE.A.

The latest lobe of that discussion was on the list here:
https://www.mail-archive.com/linux-kernel at vger.kernel.org/msg1611496.html


As it is, we would need to spot SError being delivered while SError is masked,
spray nasty messages about firmware being horrifically buggy, then panic(). For
a corrected error, this looks bad, but its preferable to letting firmware
silently overwrite the exception registers, causing linux to spin through the
vectors 'eret' with all exceptions masked.
I still think its best to wait for firmware that does the right thing.


Thanks,

James
