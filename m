From: jic23@cam.ac.uk (Jonathan Cameron)
Date: Wed, 13 Jul 2011 15:54:56 +0100
Subject: [PATCH 1/3] drivers:pcmcia:soc_common: make socket_init and
	socket_suspend optional
In-Reply-To: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
References: <1310568898-9201-1-git-send-email-jic23@cam.ac.uk>
Message-ID: <1310568898-9201-2-git-send-email-jic23@cam.ac.uk>
To: linux-arm-kernel@lists.infradead.org
List-Id: linux-arm-kernel.lists.infradead.org

10 boards define these empty, probably indicating not everyone has a use for them.

Signed-off-by: Jonathan Cameron <jic23@cam.ac.uk>
---
 drivers/pcmcia/soc_common.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/drivers/pcmcia/soc_common.c b/drivers/pcmcia/soc_common.c
index 768f957..a0a9c2a 100644
--- a/drivers/pcmcia/soc_common.c
+++ b/drivers/pcmcia/soc_common.c
@@ -186,8 +186,8 @@ static int soc_common_pcmcia_sock_init(struct pcmcia_socket *sock)
 	struct soc_pcmcia_socket *skt = to_soc_pcmcia_socket(sock);
 
 	debug(skt, 2, "initializing socket\n");
-
-	skt->ops->socket_init(skt);
+	if (skt->ops->socket_init)
+		skt->ops->socket_init(skt);
 	return 0;
 }
 
@@ -207,7 +207,8 @@ static int soc_common_pcmcia_suspend(struct pcmcia_socket *sock)
 
 	debug(skt, 2, "suspending socket\n");
 
-	skt->ops->socket_suspend(skt);
+	if (skt->ops->socket_suspend)
+		skt->ops->socket_suspend(skt);
 
 	return 0;
 }
-- 
1.7.3.4
