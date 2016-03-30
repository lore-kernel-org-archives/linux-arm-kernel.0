From: jszhang@marvell.com (Jisheng Zhang)
Date: Wed, 30 Mar 2016 21:37:00 +0800
Subject: [RFC] net: mvneta: 64bit platform support
Message-ID: <20160330213700.41876e09@xhacker>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi all,

Obviously, current mvneta driver can't work on 64bit platforms. For one thing
the BM feature should be explicitly disabled, I just sent out one patch for
this purpose. 

What's more, the buf_cookie in mvneta_rx_desc need to be carefully considered.
The driver use the buf_cookie(u32 type) to store the buffer virtual address,
obviously it can't store the virtual address on 64bit platforms. I have two
solutions:

solution A: let one reserved type in current mvneta_rx_desc, e.g reserved5
to store the high 32bit virt address, and hack code as the following:
#ifdef CONFIG_64BIT
rx_desc->reserved5 = high32(data);
#endif

solution B: add one member void **buf_virt_ptrs in mvneta_rx_queue, and point
all buf_cookie usage to the according buf_virt_ptrs[i]


Is there any elegant solutions?

Thanks,
Jisheng
