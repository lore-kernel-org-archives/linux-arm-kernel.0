From: zonque@gmail.com (Daniel Mack)
Date: Thu, 15 Aug 2013 20:12:05 +0200
Subject: [v3 1/2] dma: mmp_pdma: add support for residue reporting
In-Reply-To: <CADApbejtvXvgF8jpQAyrbY3Yr=XkBech5D6fCEM+yMj8DRRY9w@mail.gmail.com>
References: <1376497189-21298-1-git-send-email-zonque@gmail.com>
 <CADApbegKj=AMGx4OFOBVsyk71BGis97Gw9QM_-0EsNi90pS+Hw@mail.gmail.com>
 <520C4E98.6020001@gmail.com>
 <CADApbejtvXvgF8jpQAyrbY3Yr=XkBech5D6fCEM+yMj8DRRY9w@mail.gmail.com>
Message-ID: <520D19F5.7050406@gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

On 15.08.2013 10:08, Chao Xie wrote:
> In the function mmp_pdma_tx_submit
> It will assign cookie for every descriptors by
> list_for_each_entry(child, &desc->tx_list, node) {
>                 cookie = dma_cookie_assign(&child->async_tx);
>         }
> So not all the descriptors in same transaction will share same cookie.

Hmm, yes. You're right. However, I see quite some more issues with the
driver as it stands, especially due to assumptions that are made for
multiple transactions on one channel.

For example, let's think about two transactions with multiple
descriptors each, and both transactions are present in the chain_running
list. Each transaction has the ENDIRQEN bit set on the last descriptor only.

Currently, when an interrupt is caught, the code will only look at the
very last entry in the running list and complete its cookie, and then
dispose the entire running chain. Hence, the other transaction's cookie
will never complete. Even worse: as an interrupt will always be for the
first descriptor in the chain with the ENDIRQEN bit set, we complete the
second transaction that is in fact still running (and call the
completion handler for it), while we don't do exactly that for the first
one.

Am I right with the above or do I make faulty assumptions? I'll think
about how the driver can be changed in order to fix this, but it will be
more invasive than I thought.


Thanks for sharing your ideas,
Daniel
