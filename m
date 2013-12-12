From: Ian.Campbell@citrix.com (Ian Campbell)
Date: Thu, 12 Dec 2013 14:19:20 +0000
Subject: [Xen-devel] [PATCH v2] xen/block: Correctly define structures
 in public headers on ARM32 and ARM64
In-Reply-To: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
References: <1386085237-8334-1-git-send-email-julien.grall@linaro.org>
Message-ID: <1386857960.11201.57.camel@kazak.uk.xensource.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, 2013-12-03 at 15:40 +0000, Julien Grall wrote:
> On ARM (32 bits and 64 bits), the double-word is 8-bytes aligned. This will
> result on different structure from Xen and Linux repositories.
> 
> As Linux is using __packed__ attribute, it must have a 4-bytes padding before
> each "id" field.
> 
> This change breaks guest block support with older kernel. IMHO, it's acceptable
> because Xen on ARM is still on Tech Preview and the hypercall ABI is not yet
> freezed.
> 
> Only one architecture (x86_32) doesn't have 64-bit ABI for the block interface.
> Don't add padding if Linux is compiled for this architecture.

Konrad asked for confirmation that this didn't change x86.

Using
http://stackoverflow.com/questions/9788679/how-to-get-the-relative-adress-of-a-field-in-a-structure-dump-c

I created offsets.py as described there then for i386, amd64, arm, arm64
before and after I built with CONFIG_DEBUG_INFO but not
CONFIG_DEBUG_INFO_REDUCED then:

        $ cat script
        python
        sys.path.insert(0, '')
        import offsets
        end
        
        offsets-of "struct blkif_request"
        offsets-of "struct blkif_request_rw"
        offsets-of "struct blkif_request_discard"
        offsets-of "struct blkif_request_other"
        offsets-of "struct blkif_request_indirect"
        $ gdb -x script --batch drivers/block/xen-blkfront.o
        struct blkif_request {
            operation => 0
            u => 1
        }
        struct blkif_request_rw {
            nr_segments => 0
            handle => 1
            _pad1 => 3
            id => 7
            sector_number => 15
            seg => 23
        }
        struct blkif_request_discard {
            flag => 0
            _pad1 => 1
            _pad2 => 3
            id => 7
            sector_number => 15
            nr_sectors => 23
            _pad3 => 31
        }
        struct blkif_request_other {
            _pad1 => 0
            _pad2 => 1
            _pad3 => 3
            id => 7
        }
        struct blkif_request_indirect {
            indirect_op => 0
            nr_segments => 1
            _pad1 => 3
            id => 7
            sector_number => 15
            handle => 23
            _pad2 => 25
            indirect_grefs => 27
            _pad3 => 59
        }

There is no difference to either x86 arch:
        $ diff -q x86_32.{before,after} && echo same
        same
        $ diff -q x86_64.{before,after} && echo same
        same
        $
And crucially:
        $ diff -q arm.after arm64.after && echo same
        same
        $ diff -q arm.after x86_64.after && echo same
        same
        $

Full results attached.

Ian.


-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    seg => 23
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    _pad2 => 3
    id => 7
    sector_number => 15
    nr_sectors => 23
    _pad3 => 31
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    _pad3 => 3
    id => 7
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    handle => 23
    _pad2 => 25
    indirect_grefs => 27
    _pad3 => 59
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    id => 3
    sector_number => 11
    seg => 19
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    id => 3
    sector_number => 11
    nr_sectors => 19
    _pad3 => 27
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    id => 3
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    id => 3
    sector_number => 11
    handle => 19
    _pad2 => 21
    indirect_grefs => 23
    _pad3 => 55
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    seg => 23
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    _pad2 => 3
    id => 7
    sector_number => 15
    nr_sectors => 23
    _pad3 => 31
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    _pad3 => 3
    id => 7
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    handle => 23
    _pad2 => 25
    indirect_grefs => 27
    _pad3 => 59
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    id => 3
    sector_number => 11
    seg => 19
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    id => 3
    sector_number => 11
    nr_sectors => 19
    _pad3 => 27
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    id => 3
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    id => 3
    sector_number => 11
    handle => 19
    _pad2 => 21
    indirect_grefs => 23
    _pad3 => 55
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    id => 3
    sector_number => 11
    seg => 19
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    id => 3
    sector_number => 11
    nr_sectors => 19
    _pad3 => 27
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    id => 3
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    id => 3
    sector_number => 11
    handle => 19
    _pad2 => 21
    indirect_grefs => 23
    _pad3 => 55
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    id => 3
    sector_number => 11
    seg => 19
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    id => 3
    sector_number => 11
    nr_sectors => 19
    _pad3 => 27
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    id => 3
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    id => 3
    sector_number => 11
    handle => 19
    _pad2 => 21
    indirect_grefs => 23
    _pad3 => 55
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    seg => 23
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    _pad2 => 3
    id => 7
    sector_number => 15
    nr_sectors => 23
    _pad3 => 31
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    _pad3 => 3
    id => 7
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    handle => 23
    _pad2 => 25
    indirect_grefs => 27
    _pad3 => 59
}
-------------- next part --------------
struct blkif_request {
    operation => 0
    u => 1
}
struct blkif_request_rw {
    nr_segments => 0
    handle => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    seg => 23
}
struct blkif_request_discard {
    flag => 0
    _pad1 => 1
    _pad2 => 3
    id => 7
    sector_number => 15
    nr_sectors => 23
    _pad3 => 31
}
struct blkif_request_other {
    _pad1 => 0
    _pad2 => 1
    _pad3 => 3
    id => 7
}
struct blkif_request_indirect {
    indirect_op => 0
    nr_segments => 1
    _pad1 => 3
    id => 7
    sector_number => 15
    handle => 23
    _pad2 => 25
    indirect_grefs => 27
    _pad3 => 59
}
