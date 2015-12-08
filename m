From: will.deacon@arm.com (Will Deacon)
Date: Tue, 8 Dec 2015 10:30:14 +0000
Subject: ARM64: kernel oops in 4.4-rc4+
In-Reply-To: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
References: <CACVXFVPnmKzv-mnDyjOnoQtxZ4kyWLtkymK1XhDThO8ibi7f7w@mail.gmail.com>
Message-ID: <20151208103013.GA19612@arm.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Tue, Dec 08, 2015 at 02:30:33PM +0800, Ming Lei wrote:
> Hi,

[adding Catalin to cc]

> The attached kernel oops can be triggered immediately after
> running the following command on APM Mustang:
> 
>         $stress-ng --all 8 -t 10m
> 
> [1] kernel oops log
> stress-ng: info:  [5220] 5 failures reached, aborting stress process
> [  265.782659] kernel BUG at ./arch/arm64/include/asm/pgtable.h:282!

Yikes, this means we're replacing a writable pte with a clean pte, so
there's a potential race w/ hardware DBM.

Could you dump pte and *ptep please?

> [  265.788726] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
> [  265.794186] Modules linked in:
> [  265.797241] CPU: 1 PID: 15830 Comm: stress-ng-cache Tainted: G
>   W       4.4.0-rc4+ #54

What changes do you have on top of -rc4?

Will
