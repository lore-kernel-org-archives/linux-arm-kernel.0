From: slash.tmp@free.fr (Mason)
Date: Sat, 23 Jan 2016 23:46:06 +0100
Subject: Unhandled fault: page domain fault (0x81b) at 0x00e41008
In-Reply-To: <56A3E84A.1000604@free.fr>
References: <56A268E7.7040004@free.fr>
 <20160122174814.GD19062@n2100.arm.linux.org.uk> <56A27C00.5060004@free.fr>
 <20160122193408.GE19062@n2100.arm.linux.org.uk> <56A2B811.8010306@free.fr>
 <20160122235704.GF19062@n2100.arm.linux.org.uk> <56A3609E.3000400@free.fr>
 <20160123113438.GG19062@n2100.arm.linux.org.uk> <56A3E84A.1000604@free.fr>
Message-ID: <56A402AE.6070503@free.fr>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 23/01/2016 21:53, Mason wrote:

> But I would consider mmaping /dev/mem even simpler: it doesn't
> require writing a single line of kernel code, and it works as
> expected. The gist of the code is:
> 
>   fd = open("/path/to/file", O_RDONLY);
>   mem_fd = open("/dev/mem", O_WRONLY | O_SYNC);
>   va = mmap(NULL, len, PROT_WRITE, MAP_SHARED, mem_fd, phys_addr);
>   read(fd, va, len);
> 
> And that's it. If I understand correctly, the mem driver
> will copy the file contents directly to "remote" RAM.
> 
> Is there something wrong with this solution, in your opinion?

For my own reference, Arnd had several comments:

> /dev/mem is deprecated and often gets disabled because it is a
> security hole. Your driver can implement its own mmap function
> if needed.
> 
> On the user space side, you have to be careful to use aligned
> accesses on device memory, you can't just memcpy into a buffer
> from mmap()
>
> /dev/mem maps memory as MT_DEVICE, which has stricter rules
> [than ordinary RAM]. If you want an mmap of this memory, you
> should really implement your own with the correct attributes.
> 
> read may or may not do unaligned accesses, depending on a lot of
> factors like compiler optimization flags when building the kernel
