From: torvalds@linux-foundation.org (Linus Torvalds)
Date: Thu, 22 Nov 2018 08:50:47 -0800
Subject: remove the ->mapping_error method from dma_map_ops V2
In-Reply-To: <20181122140320.24080-1-hch@lst.de>
References: <20181122140320.24080-1-hch@lst.de>
Message-ID: <CAHk-=wh=_T=A53+o4zLNbKio43LGqVDb0KCbWPDvAg54bRDmWw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On Thu, Nov 22, 2018 at 6:03 AM Christoph Hellwig <hch@lst.de> wrote:
>
> The 0 return doesn't work for direct mappings that have ram at address
> zero and a lot of IOMMUs that start allocating bus space from address
> zero, so we can't consolidate on that, but I think we can move everyone
> to all-Fs, which the patch here does.

Hmm. Maybe not limit it to just all ones, but actually use the
(standard, for the kernel) IS_ERR_VALUE()?

That basically reserves the last 4095 values in an unsigned long for
error values.

Then those functions could actually return *what* error they
encountered, using just plain

        return -ENOMEM;

or whatever?

               Linus
