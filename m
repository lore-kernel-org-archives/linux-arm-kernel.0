From: davem@davemloft.net (David Miller)
Date: Tue, 10 May 2016 15:53:54 -0400 (EDT)
Subject: [PATCH 5/6] drivers: net: xgene: Using static MSS values
In-Reply-To: <1462838656-22043-6-git-send-email-isubramanian@apm.com>
References: <1462838656-22043-1-git-send-email-isubramanian@apm.com>
 <1462838656-22043-6-git-send-email-isubramanian@apm.com>
Message-ID: <20160510.155354.2183670732162584648.davem@davemloft.net>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

From: Iyappan Subramanian <isubramanian@apm.com>
Date: Mon,  9 May 2016 17:04:15 -0700

> Due to the nature of hardware design for TSO, if the MSS values that are
> stored in the register, changes during TSO operation, data corruption may
> occur.
> 
> This patch fixes the issue by using one of the predefined MSS values.
> 
> Signed-off-by: Iyappan Subramanian <isubramanian@apm.com>
> Tested-by: Toan Le <toanle@apm.com>

This is a very serious quality of implementation issue.

And it could quietly kill performance for some users, and there is no
way for them to find out that this is happening.

If you use a predefined set of MSS values, if the MSS value we need is
between two of them then there is going to be wasted space on the
wire.  It's can therefore certainly be better to not do TSO in that
case.

I think you absolutely need to disable TSO by default, and require the
user to explicitly turn it on, unless you can fix this problem in
another way.

Thanks.
