From: sunil.kovvuri@gmail.com (Sunil Kovvuri)
Date: Mon, 7 Mar 2016 22:28:39 +0530
Subject: [PATCH 1/2] net: thunderx: Set recevie buffer page usage count in
 bulk
In-Reply-To: <20160307.111534.235286977900488968.davem@davemloft.net>
References: <1457336157-31508-1-git-send-email-sunil.kovvuri@gmail.com>
 <1457336157-31508-2-git-send-email-sunil.kovvuri@gmail.com>
 <20160307.111534.235286977900488968.davem@davemloft.net>
Message-ID: <CA+sq2CewOQGSiRC5m64ioYS36-WO0C5XzykZRZd+OLE1tJ-sSQ@mail.gmail.com>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Hi David,

>> you create a window of time during which the consumer
>> can release the page and prematurely free it.
Okay, but here the consumer i.e HW is notified only after page count
is incremented.
For example if you check 'nicvf_refill_rbdr' fn() only after receive
buffer ring is
refilled with buffers, doorbell is issued to hardware to start using
the new buffers.

So
@@ -241,6 +254,8 @@ refill:
                new_rb++;
        }

+       nicvf_get_page(nic);
+
calling 'nicvf_get_page' before issuing doorbell ensures page ref
count is properly
set before hw/consumer can use the buffers.

Thanks,
Sunil.
