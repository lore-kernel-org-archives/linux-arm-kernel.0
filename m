From: arve@android.com (=?ISO-8859-1?Q?Arve_Hj=F8nnev=E5g?=)
Date: Wed, 17 Feb 2010 18:00:23 -0800
Subject: race between kmap shootdown and cache maintenance
In-Reply-To: <A0A1E7539300DF49AA383E614C7827BC048DB10A1D@HQMAIL01.nvidia.com>
References: <A0A1E7539300DF49AA383E614C7827BC048DB1096B@HQMAIL01.nvidia.com>
	<20100207153045.GA30457@n2100.arm.linux.org.uk>
	<A0A1E7539300DF49AA383E614C7827BC048DB10979@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082229480.1681@xanadu.home>
	<A0A1E7539300DF49AA383E614C7827BC048DB10984@HQMAIL01.nvidia.com>
	<alpine.LFD.2.00.1002082310420.1681@xanadu.home>
	<A0A1E7539300DF49AA383E614C7827BC048DB10A1D@HQMAIL01.nvidia.com>
Message-ID: <d6200be21002171800m7f03f94blbb17d68bce4a9302@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Fri, Feb 12, 2010 at 5:08 PM, Gary King <GKing@nvidia.com> wrote:
> I finally got a chance to test this; it looks like this condition may be common: many (all?) of the various page cache-like things seem to just hand pages to flush_dcache_page blindly, and expect flush_dcache_page to determine whether or not maintenance is required.
>
> With your patch, I immediately hit the BUG() when the init process is started; the backtrace is attached as unpinned_maint.log.

I see the same crash on Nexus One with this patch applied to a
2.6.33-rc8 kernel.

If I change the BUG_ON to WARN_ON, the system boot further, but the
warning triggers the bug.

If I also apply the fix from this thread the system boots again, and I
see several calls that do not have the kmap-high pinned.
__get_user_pages, generic_file_buffered_write, __block_prepare_write,
block_write_end, blk_queue_bounce, __mpage_writepage:

<4>[   44.110321] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   44.110534] Modules linked in:
<4>[   44.110748] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   44.110961] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   44.111175] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   44.111358] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c0091188>] (generic_file_buffered_write+0x144/0x270)
<4>[   44.111572] [<c0091188>]
(generic_file_buffered_write+0x144/0x270) from [<c0093400>]
(__generic_file_aio_write+0x48c/0x4d4)
<4>[   44.111785] [<c0093400>] (__generic_file_aio_write+0x48c/0x4d4)
from [<c00934b0>] (generic_file_aio_write+0x68/0xc8)
<4>[   44.111999] [<c00934b0>] (generic_file_aio_write+0x68/0xc8) from
[<c00bf9d8>] (do_sync_write+0x9c/0xe4)
<4>[   44.112213] [<c00bf9d8>] (do_sync_write+0x9c/0xe4) from
[<c00c03c0>] (vfs_write+0xac/0x154)
<4>[   44.112335] [<c00c03c0>] (vfs_write+0xac/0x154) from
[<c00c0514>] (sys_write+0x3c/0x68)
<4>[   44.112518] [<c00c0514>] (sys_write+0x3c/0x68) from [<c0026f40>]
(ret_fast_syscall+0x0/0x2c)


<4>[   44.148040] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   44.148193] Modules linked in:
<4>[   44.148529] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   44.148742] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   44.149047] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   44.149383] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c00e4f2c>] (__block_prepare_write+0x2c4/0x460)
<4>[   44.149688] [<c00e4f2c>] (__block_prepare_write+0x2c4/0x460)
from [<c00e52f0>] (block_write_begin+0x8c/0x104)
<4>[   44.149993] [<c00e52f0>] (block_write_begin+0x8c/0x104) from
[<c00e566c>] (cont_write_begin+0x304/0x344)
<4>[   44.150329] [<c00e566c>] (cont_write_begin+0x304/0x344) from
[<c01361c0>] (fat_write_begin+0x48/0x54)
<4>[   44.150512] [<c01361c0>] (fat_write_begin+0x48/0x54) from
[<c0091124>] (generic_file_buffered_write+0xe0/0x270)
<4>[   44.150848] [<c0091124>]
(generic_file_buffered_write+0xe0/0x270) from [<c0093400>]
(__generic_file_aio_write+0x48c/0x4d4)
<4>[   44.151153] [<c0093400>] (__generic_file_aio_write+0x48c/0x4d4)
from [<c00934b0>] (generic_file_aio_write+0x68/0xc8)
<4>[   44.151489] [<c00934b0>] (generic_file_aio_write+0x68/0xc8) from
[<c00bf9d8>] (do_sync_write+0x9c/0xe4)
<4>[   44.151794] [<c00bf9d8>] (do_sync_write+0x9c/0xe4) from
[<c00c03c0>] (vfs_write+0xac/0x154)
<4>[   44.152099] [<c00c03c0>] (vfs_write+0xac/0x154) from
[<c00c0514>] (sys_write+0x3c/0x68)
<4>[   44.152435] [<c00c0514>] (sys_write+0x3c/0x68) from [<c0026f40>]
(ret_fast_syscall+0x0/0x2c)


<4>[   44.158935] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   44.159240] Modules linked in:
<4>[   44.159576] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   44.159881] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   44.160217] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   44.160522] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c00e37c0>] (block_write_end+0x4c/0x68)
<4>[   44.160858] [<c00e37c0>] (block_write_end+0x4c/0x68) from
[<c00e3810>] (generic_write_end+0x34/0xd0)
<4>[   44.161041] [<c00e3810>] (generic_write_end+0x34/0xd0) from
[<c0136124>] (fat_write_end+0x2c/0x80)
<4>[   44.161346] [<c0136124>] (fat_write_end+0x2c/0x80) from
[<c00911c0>] (generic_file_buffered_write+0x17c/0x270)
<4>[   44.161682] [<c00911c0>]
(generic_file_buffered_write+0x17c/0x270) from [<c0093400>]
(__generic_file_aio_write+0x48c/0x4d4)
<4>[   44.161987] [<c0093400>] (__generic_file_aio_write+0x48c/0x4d4)
from [<c00934b0>] (generic_file_aio_write+0x68/0xc8)
<4>[   44.162292] [<c00934b0>] (generic_file_aio_write+0x68/0xc8) from
[<c00bf9d8>] (do_sync_write+0x9c/0xe4)
<4>[   44.162628] [<c00bf9d8>] (do_sync_write+0x9c/0xe4) from
[<c00c03c0>] (vfs_write+0xac/0x154)
<4>[   44.162933] [<c00c03c0>] (vfs_write+0xac/0x154) from
[<c00c0514>] (sys_write+0x3c/0x68)
<4>[   44.163116] [<c00c0514>] (sys_write+0x3c/0x68) from [<c0026f40>]
(ret_fast_syscall+0x0/0x2c)
<4>[   44.163574] ---[ end trace 1b75b31a2719f026 ]---


<4>[   48.068237] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   48.068878] Modules linked in:
<4>[   48.069580] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   48.070251] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   48.070617] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   48.071289] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c00b40dc>] (blk_queue_bounce+0x170/0x30c)
<4>[   48.071960] [<c00b40dc>] (blk_queue_bounce+0x170/0x30c) from
[<c0162694>] (__make_request+0x44/0x424)
<4>[   48.072631] [<c0162694>] (__make_request+0x44/0x424) from
[<c0161074>] (generic_make_request+0x300/0x360)
<4>[   48.073303] [<c0161074>] (generic_make_request+0x300/0x360) from
[<c01611e0>] (submit_bio+0x10c/0x128)
<4>[   48.073944] [<c01611e0>] (submit_bio+0x10c/0x128) from
[<c00e26ac>] (submit_bh+0x170/0x194)
<4>[   48.074340] [<c00e26ac>] (submit_bh+0x170/0x194) from
[<c00e5e5c>] (__block_write_full_page+0x35c/0x4f8)
<4>[   48.074981] [<c00e5e5c>] (__block_write_full_page+0x35c/0x4f8)
from [<c00e60e0>] (block_write_full_page_endio+0xe8/0xec)
<4>[   48.075653] [<c00e60e0>] (block_write_full_page_endio+0xe8/0xec)
from [<c00ebfe4>] (__mpage_writepage+0x60c/0x65c)
<4>[   48.076324] [<c00ebfe4>] (__mpage_writepage+0x60c/0x65c) from
[<c0098da0>] (write_cache_pages+0x1f4/0x2f8)
<4>[   48.076995] [<c0098da0>] (write_cache_pages+0x1f4/0x2f8) from
[<c00ec210>] (mpage_writepages+0x48/0x70)
<4>[   48.087097] [<c00ec210>] (mpage_writepages+0x48/0x70) from
[<c0098ef8>] (do_writepages+0x2c/0x38)
<4>[   48.087829] [<c0098ef8>] (do_writepages+0x2c/0x38) from
[<c00dc7ac>] (writeback_single_inode+0x108/0x2fc)
<4>[   48.088195] [<c00dc7ac>] (writeback_single_inode+0x108/0x2fc)
from [<c00dd578>] (writeback_inodes_wb+0x3d0/0x52c)
<4>[   48.088867] [<c00dd578>] (writeback_inodes_wb+0x3d0/0x52c) from
[<c00dd80c>] (wb_writeback+0x138/0x1d0)
<4>[   48.089508] [<c00dd80c>] (wb_writeback+0x138/0x1d0) from
[<c00ddb6c>] (wb_do_writeback+0x19c/0x1c0)
<4>[   48.090179] [<c00ddb6c>] (wb_do_writeback+0x19c/0x1c0) from
[<c00ddbc8>] (bdi_writeback_task+0x38/0xb4)
<4>[   48.090820] [<c00ddbc8>] (bdi_writeback_task+0x38/0xb4) from
[<c00a4fe8>] (bdi_start_fn+0x8c/0x104)
<4>[   48.091491] [<c00a4fe8>] (bdi_start_fn+0x8c/0x104) from
[<c006cfe8>] (kthread+0x78/0x80)
<4>[   48.091857] [<c006cfe8>] (kthread+0x78/0x80) from [<c002797c>]
(kernel_thread_exit+0x0/0x8)


<4>[   48.107055] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   48.107360] Modules linked in:
<4>[   48.107574] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   48.107788] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   48.108001] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   48.108123] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c00ebdd4>] (__mpage_writepage+0x3fc/0x65c)
<4>[   48.108337] [<c00ebdd4>] (__mpage_writepage+0x3fc/0x65c) from
[<c0098da0>] (write_cache_pages+0x1f4/0x2f8)
<4>[   48.112121] [<c0098da0>] (write_cache_pages+0x1f4/0x2f8) from
[<c00ec210>] (mpage_writepages+0x48/0x70)
<4>[   48.112335] [<c00ec210>] (mpage_writepages+0x48/0x70) from
[<c0098ef8>] (do_writepages+0x2c/0x38)
<4>[   48.112548] [<c0098ef8>] (do_writepages+0x2c/0x38) from
[<c00dc7ac>] (writeback_single_inode+0x108/0x2fc)
<4>[   48.112792] [<c00dc7ac>] (writeback_single_inode+0x108/0x2fc)
from [<c00dd578>] (writeback_inodes_wb+0x3d0/0x52c)
<4>[   48.113006] [<c00dd578>] (writeback_inodes_wb+0x3d0/0x52c) from
[<c00dd80c>] (wb_writeback+0x138/0x1d0)
<4>[   48.113098] [<c00dd80c>] (wb_writeback+0x138/0x1d0) from
[<c00ddb6c>] (wb_do_writeback+0x19c/0x1c0)
<4>[   48.113311] [<c00ddb6c>] (wb_do_writeback+0x19c/0x1c0) from
[<c00ddbc8>] (bdi_writeback_task+0x38/0xb4)
<4>[   48.113525] [<c00ddbc8>] (bdi_writeback_task+0x38/0xb4) from
[<c00a4fe8>] (bdi_start_fn+0x8c/0x104)
<4>[   48.113739] [<c00a4fe8>] (bdi_start_fn+0x8c/0x104) from
[<c006cfe8>] (kthread+0x78/0x80)
<4>[   48.113952] [<c006cfe8>] (kthread+0x78/0x80) from [<c002797c>]
(kernel_thread_exit+0x0/0x8)


<4>[   87.644622] WARNING: at arch/arm/mm/flush.c:129
__flush_dcache_page+0x58/0xe4()
<4>[   87.645233] Modules linked in:
<4>[   87.646087] [<c002b878>] (unwind_backtrace+0x0/0xd8) from
[<c0058318>] (warn_slowpath_common+0x48/0x60)
<4>[   87.646759] [<c0058318>] (warn_slowpath_common+0x48/0x60) from
[<c002d114>] (__flush_dcache_page+0x58/0xe4)
<4>[   87.647430] [<c002d114>] (__flush_dcache_page+0x58/0xe4) from
[<c002d238>] (flush_dcache_page+0x98/0xe4)
<4>[   87.648101] [<c002d238>] (flush_dcache_page+0x98/0xe4) from
[<c00a84d4>] (__get_user_pages+0x1ec/0x25c)
<4>[   87.648773] [<c00a84d4>] (__get_user_pages+0x1ec/0x25c) from
[<c00c4938>] (get_arg_page+0x48/0x9c)
<4>[   87.649139] [<c00c4938>] (get_arg_page+0x48/0x9c) from
[<c00c4a80>] (copy_strings+0xf4/0x208)
<4>[   87.649810] [<c00c4a80>] (copy_strings+0xf4/0x208) from
[<c00c63f4>] (do_execve+0x118/0x260)
<4>[   87.650451] [<c00c63f4>] (do_execve+0x118/0x260) from
[<c0029ef4>] (sys_execve+0x34/0x54)
<4>[   87.651092] [<c0029ef4>] (sys_execve+0x34/0x54) from
[<c0026f40>] (ret_fast_syscall+0x0/0x2c)


...
> From: Nicolas Pitre [mailto:nico at fluxnic.net]
> But that's where things seem wrong. ?There should no be any caller of
> flush_dcache_page() passing a page with no "owner".
>

What to you mean by "owner"? It looks like the page is locked, but the
highmem mapping is not.

-- 
Arve Hj?nnev?g
