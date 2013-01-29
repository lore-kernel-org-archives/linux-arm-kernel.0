From: dsterba@suse.cz (David Sterba)
Date: Tue, 29 Jan 2013 23:55:14 +0100
Subject: [RFC PATCH 0/4] Add support for LZ4-compressed kernels
In-Reply-To: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
References: <1359179447-31118-1-git-send-email-kyungsik.lee@lge.com>
Message-ID: <20130129225508.GC30535@twin.jikos.cz>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sat, Jan 26, 2013 at 02:50:43PM +0900, Kyungsik Lee wrote:
> This patchset is for supporting LZ4 compressed kernel and initial ramdisk on
> the x86 and ARM architectures.

Have you considered the 'high compression' mode of lz4?
http://code.google.com/p/lz4/source/browse/trunk/lz4hc.c

The compression format remains the same, the compressor tries harder
(but is slower), resulting compression ratio is better.

an examle compression for vmlinux.bin of x86_64 build:

input size: 16509520 bytes

lz4 (svn 88):
output size:        6393684    (38.7%)
compression time:      41.7 ms (395 MB/s)
decompression time:    13.7 ms (1204 MB/s)

lz4hc (svn 88):
output size:        5319137    (32.2%)
compression time:       683 ms (24 MB/s)
decompression time:    13.1 ms (1259 MB/s)

compressed file delta: 6393684 - 5319137 = 1074547 ~ 1MB

tested on a Nehalem box; same test on my slow desktop gives

lz4:
compression time:      97   ms (169 MB/s)
decompression time:    25.7 ms (643 MB/s)

lz4hc:
compression time:    1386 ms (11 MB/s)
decompression time:    26 ms (619 MB/s)

While the decompression time is almost the same, image size is smaller.
The kernel image compression is run in userspace and the low speed is
not much of concern for a one-time operation.

For the reference, lzo (current kernel version) run on the destktop:

output size:         6026256 (36.5%)
decompression time:     79.6 ms (207 MB/s)

> It seems that it?s worth trying LZ4 compressed kernel image or ramdisk 
> for making the kernel boot more faster.

There's another potential user of lz4: btrfs. I've submitted a feature
preview integrating lz4 compression
http://thread.gmane.org/gmane.comp.file-systems.btrfs/15744
and we have tried to integrate the HC mode as well
http://thread.gmane.org/gmane.comp.file-systems.btrfs/18165
.
So far it's on a slow track, conceptually it works, but I the code needs
some work so it could live under lib/* (we've used the svn sources
with minor changes, no kernel coding style). It would be easier for me
to enhance the existing lib/lz4/* codebase.

Also zram could consider lz4, I'm not sure if there are other potential
users.


david
