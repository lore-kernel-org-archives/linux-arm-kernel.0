From: davem@davemloft.net (David Miller)
Date: Thu, 11 May 2017 12:42:17 -0400 (EDT)
Subject: [PATCH net] bpf, arm64: fix faulty emission of map access in
 tail calls
In-Reply-To: <0e928e7c351b962a16376a2ab29e2af1c5b4c027.1494459589.git.daniel@iogearbox.net>
References: <0e928e7c351b962a16376a2ab29e2af1c5b4c027.1494459589.git.daniel@iogearbox.net>
Message-ID: <20170511.124217.2072353083791799566.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Daniel Borkmann <daniel@iogearbox.net>
Date: Thu, 11 May 2017 01:53:15 +0200

> Shubham was recently asking on netdev why in arm64 JIT we don't multiply
> the index for accessing the tail call map by 8. That led me into testing
> out arm64 JIT wrt tail calls and it turned out I got a NULL pointer
> dereference on the tail call.
 ...
> Fix this by emitting the following instead:
> 
>   [...]
>   00000060:  d2800e0a  mov x10, #0x70 // #112
>   00000064:  8b0a002a  add x10, x1, x10
>   00000068:  d37df04b  lsl x11, x2, #3
>   0000006c:  f86b694b  ldr x11, [x10,x11]
>   00000070:  b40000ab  cbz x11, 0x00000084
>   [...]
> 
> This basically adds the offset to ptrs to the base address of the bpf
> array we got and we later on access the map with an index * 8 offset
> relative to that. The tail call map itself is basically one large area
> with meta data at the head followed by the array of prog pointers.
> This makes tail calls working again, tested on Cavium ThunderX ARMv8.
> 
> Fixes: ddb55992b04d ("arm64: bpf: implement bpf_tail_call() helper")
> Reported-by: Shubham Bansal <illusionist.neo@gmail.com>
> Signed-off-by: Daniel Borkmann <daniel@iogearbox.net>

Applied and queued up for -stable, thanks.
