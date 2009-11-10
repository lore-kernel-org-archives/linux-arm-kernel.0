From: papalagi.pakeha@gmail.com (Papalagi Pakeha)
Date: Wed, 11 Nov 2009 02:08:27 +1300
Subject: Runtime code modification fails on arm
Message-ID: <343d1bca0911100508w1b5b62d8n8242abd7eb97a0c@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi,

I've got a program that is stored partially encrypted on the
filesystem and should decrypt itself in runtime after retrieving the
key from the hardware.

Essentially the implementation puts some of the program functions into
a separate ELF section (.cryptext) and then a helper script encrypts
this section directly in the binary file. Offset and size is
determined using "objdump -h".

When the program is started it finds the address of the encrypted
function, its length and decrypts it back to the original valid
instructions. This all works just fine on x86 but the same approach
fails on ARM. There the decryptor can read the encrypted code, can
write back the decrypted code, can verify that the code has been
written but once the function is called it segfaults or dies on
invalid instruction. To me it looks like the changed code is not
picked up and the cpu still tries to run the old, encrypted one.

Why is this happening? What is so different between x86 and ARM in
that field? I'm aware that my problem exhibits in userspace, not in
the kernel. I'm sorry if it's way off topic here.

Some relevant snippets of my code.

// This function will get encrypted
static char *treasure(void) __attribute__((section (".cryptext")));
static char *treasure(void)
{
        return message;
}

static void decrypt(void)
{
        unsigned char *addr;
        int i;
        // decrypt all bytes of 'treasure()' function
        for (addr = (unsigned char *)treasure; addr < (unsigned char
*)treasure_key; addr++)
                *addr ^= 0x01;    // For now this is our "encryption"
}

To make .cryptext writable and to find out how long treasure()
function is I link the above with a simple asm file:
// cryptext-secrion-arm.s
        .section        .cryptext,"axw",%progbits
        .type   treasure_key, %function
        .globl  treasure_key
treasure_key:
        .size   treasure_key, .-treasure_key

Note the "axw" in .section declaration - the "w" makes the section
writable and enables decrypt() update the code. Objdump confirms that:
 11 .text         000003b8  00008388  00008388  00000388  2**2
                  CONTENTS, ALLOC, LOAD, READONLY, CODE
 12 .cryptext     0000001c  00008740  00008740  00000740  2**2
                  CONTENTS, ALLOC, LOAD, CODE                <== this
is not READONLY

Complete source demonstrating the behaviour is here:
http://cryptext.s3.amazonaws.com/cryptext.tar.gz - can be compiled
either for x86 or for ARM

Unpacked files are available from here for your convenience:
http://cryptext.s3.amazonaws.com/index.html

Does anyone have an idea what could be wrong here? Why does it work on
x86 but fails to pick up the decrypted instructions on ARM? FWIW we
use Samsung S3C2410 with kernel 2.6.27 and gcc 4.2.4 with glibc 2.3.3
toolchain.

Any hints are welcome!

Thanks

PaPa
