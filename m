From: ben.dooks@codethink.co.uk (Ben Dooks)
Date: Mon, 22 Jul 2013 18:20:10 +0100
Subject: [PATCH 4/4] ARM: set --be8 when linking modules
In-Reply-To: <20130722170500.GC19639@codeaurora.org>
References: <1374510833-25716-1-git-send-email-ben.dooks@codethink.co.uk>
 <1374510833-25716-5-git-send-email-ben.dooks@codethink.co.uk>
 <20130722170500.GC19639@codeaurora.org>
Message-ID: <51ED69CA.3030501@codethink.co.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 22/07/13 18:05, Stephen Boyd wrote:
> On 07/22, Ben Dooks wrote:
>> To avoid having to make every text section swap the instruction order
>> of all instructions, make sure modules are built also built with --be8
>> (as is the current kernel final link).
>>
>> If we do not do this, we would end up having to swap all instructions
>> when loading a module, instead of just the instructions that we are
>> applying ELF relocations to.
>>
>
> If someone tries to load a be8 module on a non-be8 kernel will it
> still work? Or should we add an extra version magic string in
> asm/module.h to prevent that?

The ELF header changes the EI_DATA field in the ei_ident from
ELFDATA2LSB to ELFDATA2MSB when compiling so we should be able
to detect these when loading.

I have not checked to see if the kernel correctly checks for this.

I do not think it currently checks the ei_flags field for the
EF_ARM_BE8 in ABI 4 and 5. I am not sure if this is really important?

-- 
Ben Dooks				http://www.codethink.co.uk/
Senior Engineer				Codethink - Providing Genius
