From: kevin.brodsky@arm.com (Kevin Brodsky)
Date: Fri, 4 Nov 2016 11:53:43 -0600
Subject: [RFC PATCH v2 8/8] arm64: Wire up and expose the new compat vDSO
In-Reply-To: <20161104164743.c35wxhgzs6uigv6j@localhost>
References: <20161027163058.12156-1-kevin.brodsky@arm.com>
 <20161027163058.12156-9-kevin.brodsky@arm.com>
 <20161104155039.5lxubpyt2dsuqxef@localhost>
 <3fb402fd-a080-f327-6d86-c2d341c5e7d9@arm.com>
 <20161104164743.c35wxhgzs6uigv6j@localhost>
Message-ID: <8a7315b7-3f9a-f60d-1fa6-00f98a31ce8d@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 04/11/2016 10:47, Catalin Marinas wrote:
> On Fri, Nov 04, 2016 at 10:30:08AM -0600, Kevin Brodsky wrote:
>> On 04/11/2016 09:50, Catalin Marinas wrote:
>>> On Thu, Oct 27, 2016 at 05:30:58PM +0100, Kevin Brodsky wrote:
>>>> * The vDSO page replaces the vector page. The vDSO provides its own
>>>>     sigreturn trampolines, replacing those in the vector page, but the
>>>>     kuser helpers are gone. As a result enabling the compat vDSO will
>>>>     break userspace programs relying on the kuser helpers.
>>> I think vDSO and vectors page should not exclude each other. If you want
>>> to disable the vectors page, let's make it an independent config option
>>> like the KUSER_HELPERS in arch/arm64/mm/Kconfig. But I would very much
>>> like to be able to have both the vDSO and the vectors page at the same
>>> time.
>> Indeed, I've had exactly the same feedback from Google yesterday (apparently
>> many Android apps with native libs still target ARMv6....). I'll add the
>> option to keep the kuser helpers.
>>
>> There's a small problem though: how to ensure that the kuser helpers +
>> sigreturn trampolines are always included if the compat vDSO is not built? I
>> can enforce CONFIG_KUSER_HELPERS if !CONFIG_VDSO32 (directly in the
>> code/Makefiles), but the dependency cannot be expressed in Kconfig.
> Or you could insert a separate "sigpage" as arm32 does. This could leave
> independently of vDSO or vectors page.

Yeah I thought about this too. It's a bit more work but probably cleaner and more 
flexible, that would also allow to disable the kuser helpers independently of the 
compat vDSO.

Thanks,
Kevin
