From: catalin.marinas@arm.com (Catalin Marinas)
Date: Wed, 3 Oct 2012 11:02:13 +0100
Subject: [PATCH] ARM: MMUless Core: Fix insmod error - module
 relocation out of range
In-Reply-To: <20121003094801.GG6933@n2100.arm.linux.org.uk>
References: <4995c6bc655337598b88bef025cd48b320c2ada0.1349235619.git.pratyush.anand@st.com>
 <CAHkRjk5gLSWG0uiSAK9wnLDi19bEPMpFAFfbqXjz6xNH1W4HXw@mail.gmail.com>
 <20121003094801.GG6933@n2100.arm.linux.org.uk>
Message-ID: <20121003100213.GB31930@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Wed, Oct 03, 2012 at 10:48:02AM +0100, Russell King - ARM Linux wrote:
> On Wed, Oct 03, 2012 at 10:25:09AM +0100, Catalin Marinas wrote:
> > On 3 October 2012 04:43, Pratyush Anand <pratyush.anand@st.com> wrote:
> > > From: Neha MAKHIJA <neha.makhija-ext@st.com>
> > >
> > > ARM supports 32Mb jump. Hence branch instruction has a limited range.
> > >
> > > For MMU systems, the module area is located just before the kernel memory
> > > because this allows function calls to be linked directly without any indirect
> > > branches.
> > >
> > > In case of MMU-less system, Module area is given whole of the DDR address
> > > space.  Since, module_alloc() calls vmalloc(), the module area goes outside the
> > > allowed jump range. Due to this insmod will not be able to load the modules
> > > giving out of range relocation errors.
> > >
> > > Solution - Add the mlong-calls flags while compiling the modules. This tells
> > > the compiler to perform function calls by first loading the address of the
> > > function and then performing a subroutine function call on this register.
> > 
> > Do we need the module loader to handle additional relocations or they
> > are all already handled?
> 
> I have explained this extensively when the 2.6 module loader came into
> being.  It's not about additional relocations, it's about the addressible
> range of the 'b' instruction.

But doesn't -mlong-calls generate the function calls by first loading
the address in a register?

-- 
Catalin
