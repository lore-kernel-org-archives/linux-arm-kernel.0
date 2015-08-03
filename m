From: p.fedin@samsung.com (Pavel Fedin)
Date: Mon, 03 Aug 2015 09:41:33 +0300
Subject: [PATCH v2 14/15] KVM: arm64: implement MSI injection in ITS
 emulation
In-Reply-To: <55BE7BA1.40403@arm.com>
References: <1436538111-4294-1-git-send-email-andre.przywara@arm.com>
 <1436538111-4294-15-git-send-email-andre.przywara@arm.com>
 <55BB7678.5080105@linaro.org> <55BE7BA1.40403@arm.com>
Message-ID: <00a201d0cdb7$70a623f0$51f26bd0$@samsung.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

 Hi!

> When I reworked our code to only use a flag and not a separate routing
> type I ended up with the flag only guarding assignments, which wouldn't
> hurt if done unconditionally (since they are all u32's). So the whole
> usage of the flag is somewhat in jeopardy now.
> Either the eventual MSI consumer requires a DevID (ITS emulation, which
> will not work without it) or the consumer does not care at all and can
> totally ignore it (GICv2m). So I think we can always pass on the DevID

 I have just checked my current code, and you know what... You are right. We already have a per-VM
capability which actually tells us that MSIs for this VM require devID. Therefore, we really don't
need this flag at all, neither for MSI doorbell, nor for GSI routing.
 All we need is 'devid' field, which indeed can be just ignored for GICv2(m), just for simplicity.
Ignoring would happen automatically, because IIRC older kernels do not explicitly check 'pad' for
being zero, do they? And indeed in this case the userland can supply devid unconditionally, making
things even simpler.

Kind regards,
Pavel Fedin
Expert Engineer
Samsung Electronics Research center Russia
