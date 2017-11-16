From: samitolvanen@google.com (Sami Tolvanen)
Date: Thu, 16 Nov 2017 09:11:52 -0800
Subject: [PATCH v2 11/18] arm64: make mrs_s and msr_s macros work with LTO
In-Reply-To: <20171116170144.GR10515@gate.crashing.org>
References: <20171115213428.22559-1-samitolvanen@google.com>
 <20171115213428.22559-12-samitolvanen@google.com>
 <20171116115433.GG9361@arm.com>
 <20171116130742.wijnukjetoupi4hc@yury-thinkpad>
 <20171116135650.GQ10515@gate.crashing.org>
 <20171116164608.GG94341@samitolvanen.mtv.corp.google.com>
 <20171116170144.GR10515@gate.crashing.org>
Message-ID: <20171116171152.GH94341@samitolvanen.mtv.corp.google.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 16, 2017 at 11:01:44AM -0600, Segher Boessenkool wrote:
> The thing with .purgem can work.  Inelegant, sure, but it can work :-)

It works, there are already functions in the kernel that use these
macros more than once. I agree that this might not be the most elegant
solution, but at least it allows us to use the same code path for both
compilers.

> Just make sure you do the macro define, the code that uses it, and the
> undefine, all in the same inline asm statement.

Yes, that's what we're doing here. Only KVM uses msr_s/msr_s directly,
everything else uses the (read|write)_sysreg_s wrappers instead, which
means the DEFINE/UNDEFINE macros are only needed in few places.

Sami
