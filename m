From: loke.chetan@gmail.com (chetan loke)
Date: Fri, 2 Sep 2011 10:00:16 -0400
Subject: FW: [PATCH] af_packet: flush complete kernel cache in
	packet_sendmsg
In-Reply-To: <D3F292ADF945FB49B35E96C94C2061B90A239361@nsmail.netscout.com>
References: <20110505141107.GC30443@orbit.nwl.cc>
	<1314961686-30870-1-git-send-email-phil.sutter@viprinet.com>
	<D3F292ADF945FB49B35E96C94C2061B90A239361@nsmail.netscout.com>
Message-ID: <CAAsGZS6Tt9FLXfanH1+DgKt_9gR_YPJ8kX_pryhnzWTQVkNkNw@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

>
> This flushes the cache before and after accessing the mmapped packet
> buffer. It seems like the call to flush_dcache_page from inside
> __packet_get_status is not enough on Kirkwood (or ARM in general).



> + ? ? ? kw_extra_cache_flush();
> + ? ? ? rc = po->tx_ring.pg_vec ? tpacket_snd(po, msg) :
> + ? ? ? ? ? ? ? ? ? ? ? packet_snd(sock, msg, len);
> + ? ? ? kw_extra_cache_flush();
> + ? ? ? return rc;
> ?}

If a workaround is needed for mmap, then why not change tpacket_snd?

Also, is this workaround actually working for all the cases? Because
packet_get_status is not being touched in your patch.

Also, I don't see any changes for the Rx-path. Is that working ok?


Chetan Loke
