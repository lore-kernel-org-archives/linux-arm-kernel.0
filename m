From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 30 Apr 2010 08:47:45 +0100
Subject: [2.6.34-rc6] ARM: build breaks with KPROBES
In-Reply-To: <EAF47CD23C76F840A9E7FCE10091EFAB02C52179C0@dbde02.ent.ti.com>
References: <EAF47CD23C76F840A9E7FCE10091EFAB02C52179C0@dbde02.ent.ti.com>
Message-ID: <20100430074745.GA7874@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Apr 30, 2010 at 12:51:49PM +0530, Shilimkar, Santosh wrote:
> Russell,
> 
> The latest mainline ARM build breaks with KPROBES enabled. Anand
> Gadiyar did git bisect and figured out that below commit breaks the build.
> 	commit :4260415f6a3b92c5c986398d96c314df37a4ccbf

Did you read the comments in the commit message to understand why
.previous is dangerous?

> I tried matching the sections but failed to fix the build error. Below
> is the hack patch to keep build working.

The previous section is not .text, but:

#ifdef CONFIG_KPROBES
        .section        .kprobes.text,"ax",%progbits
#else
        .text
#endif

Either change the preceding .data to .pushsection .data, and the following
.text to .popsection, or duplicate the above ifdef; .pushsection/.popsection
is _far_ safer than using .previous.
