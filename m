From: dan.carpenter@oracle.com (Dan Carpenter)
Date: Fri, 14 Jul 2017 15:05:12 +0300
Subject: [PATCH 14/14] [media] fix warning on v4l2_subdev_call() result
 interpreted as bool
In-Reply-To: <20170714093938.1469319-1-arnd@arndb.de>
References: <20170714092540.1217397-1-arnd@arndb.de>
 <20170714093938.1469319-1-arnd@arndb.de>
Message-ID: <20170714120512.ioe67nnloqivtbr7@mwanda>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

Changing:

- if (!frob()) {
+ if (frob() == 0) {

is a totally pointless change.  They're both bad, because they're doing
success testing instead of failure testing, but probably the second one
is slightly worse.

This warning seems dumb.  I can't imagine it has even a 10% success rate
at finding real bugs.  Just disable it.

Changing the code to propagate error codes, is the right thing of course
so long as it doesn't introduce bugs.

regards,
dan carpenter
