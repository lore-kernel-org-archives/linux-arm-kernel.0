From: linux@arm.linux.org.uk (Russell King - ARM Linux)
Date: Fri, 21 May 2010 19:43:39 +0100
Subject: RFC: fix misplaced .note.gnu.build-id section
In-Reply-To: <20100521133612.GA30171@sig21.net>
References: <20100521133612.GA30171@sig21.net>
Message-ID: <20100521184339.GA11042@n2100.arm.linux.org.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, May 21, 2010 at 03:36:12PM +0200, Johannes Stezenbach wrote:
> when building with a binutils version which supports --build-id
> the .note.gnu.build-id section is placed at address 0 in the
> resulting vmlinux ELF file:
> 
> Program Header:
>     LOAD off    0x00008000 vaddr 0x00000000 paddr 0x00000000 align 2**15
>          filesz 0x00000024 memsz 0x00000024 flags r--
>     LOAD off    0x00010000 vaddr 0xc0008000 paddr 0xc0008000 align 2**15
>          filesz 0x0033cb60 memsz 0x0036df04 flags rwx
>     NOTE off    0x00008000 vaddr 0x00000000 paddr 0x00000000 align 2**2
>          filesz 0x00000024 memsz 0x00000024 flags r--

There seems to be little reason for the note to be loaded into memory -
maybe the right fix is to ensure that the note doesn't get placed into
a loadable output section.
