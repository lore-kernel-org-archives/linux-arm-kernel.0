From: andreiw@motorola.com (Andrei Warkentin)
Date: Tue, 22 Feb 2011 00:42:59 -0600
Subject: MMC quirks relating to performance/lifetime.
In-Reply-To: <201102201603.41856.arnd@arndb.de>
References: <AANLkTikh4vfS7SLKAa-aUXhbTxcHzYHmBuaXj1qHHYN9@mail.gmail.com>
	<201102191054.48706.arnd@arndb.de>
	<AANLkTi=GO8N15pCnZWuuJ6FfyQMytFt23LPS5oYMNuMu@mail.gmail.com>
	<201102201603.41856.arnd@arndb.de>
Message-ID: <AANLkTin0BVMgpjmeg682F7zcJJajRumLYcsgNriBwX2v@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Sun, Feb 20, 2011 at 9:03 AM, Arnd Bergmann <arnd@arndb.de> wrote:
>
> From your flashbench -a run, I would guess that it uses
> 8 MB allocation units, although the data is not 100% conclusive
> there.
>

Because the 8MB aligned write time is significantly faster, right?

>
> My interpretation is that it uses 16 KB pages, but can do two page-sized
> writes in a single access (multi-plane write). Anything smaller than
> a page goes to a temporary buffer first (like the Toshiba chip), but
> gets flushed when the next one is not contiguous. If you manage to fill
> the entire 16 KB page using small contiguous writes, it can do a single
> efficient write access instead.
>
> To confirm that 16 KB is the page size, you can try
>
> flashbench -s --scatter-span=1 --scatter-order=10 -o plot.data \
> ? ? ? ?/dev/mmcblk1 -c 32 --blocksize=16384
> gnuplot -p -e 'plot "plot.data" '
>
> On most MLC flashes, this will show a pattern alternating between slow
> and fast pages like the one from https://lwn.net/Articles/428836/

Cool.

I am attaching some graphs. The 16k sandisk shows the slow and fast
page parallel lines, as does the 8k toshiba (but we knew it for the
toshiba case), but the boundaries are strange for the sandisk case,
and there an interesting 2mb variation in the toshiba 8k graph. What
is the correct way to interpret graphs with other block sizes?

A
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_8k_read_ts.png
Type: image/png
Size: 11238 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0006.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_8k_sandisk.png
Type: image/png
Size: 8964 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0007.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_16k_sandisk.png
Type: image/png
Size: 6853 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0008.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_32k_read_ts.png
Type: image/png
Size: 9471 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0009.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_32k_sandisk.png
Type: image/png
Size: 6790 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0010.png>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: scatter_16k_read_ts.png
Type: image/png
Size: 9040 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-arm-kernel/attachments/20110222/220679a1/attachment-0011.png>
