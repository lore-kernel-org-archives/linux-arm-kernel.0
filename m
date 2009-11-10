From: matthieu.castet@parrot.com (Matthieu CASTET)
Date: Tue, 10 Nov 2009 14:19:50 +0100
Subject: Runtime code modification fails on arm
In-Reply-To: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
References: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
Message-ID: <4AF96876.3090105@parrot.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Papalagi Pakeha a ?crit :
> Hi,
> 
> I've got a program that is stored partially encrypted on the
> filesystem and should decrypt itself in runtime after retrieving the
> key from the hardware.
> 
> Essentially the implementation puts some of the program functions into
> a separate ELF section (.cryptext) and then a helper script encrypts
> this section directly in the binary file. Offset and size is
> determined using "objdump -h".
> 
> When the program is started it finds the address of the encrypted
> function, its length and decrypts it back to the original valid
> instructions. This all works just fine on x86 but the same approach
> fails on ARM. There the decryptor can read the encrypted code, can
> write back the decrypted code, can verify that the code has been
> written but once the function is called it segfaults or dies on
> invalid instruction. To me it looks like the changed code is not
> picked up and the cpu still tries to run the old, encrypted one.
> 
> Why is this happening? What is so different between x86 and ARM in
> that field? I'm aware that my problem exhibits in userspace, not in
> the kernel. I'm sorry if it's way off topic here.
You need to flush the data cache and invalidate instruction one. For
that you can use __ARM_NR_cacheflush syscall.


Matthieu
