Return-Path: <SRS0=tmGn=OI=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5443BC41536
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:29 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25E162145D
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Thu, 29 Nov 2018 17:47:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Y0GyocKM";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="kQ6AMKNV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25E162145D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=ny9TC4iOhRklHyaT0O9UACIXdhbDAqDABVAURkRmNIA=; b=Y0GyocKMxN0Pr9iEOayfwqlCC8
	ykAMQwNXqndInudWEUQmF0iA3U9LALNjnaFajXJeZN1yBymGe4DFxuu2IM+KXVJ5TRUMhK0rZK47o
	whjwMUd+40thyVFyxIXw5HlOVV7AzsbpIKMb7csUoLUBJCL9/R/uHYK75vtabNLXJ9h75NuueGBhK
	+erX/klszCwPEcuXaX04gjxnBpF8Jok+Du7Jr4CAj4/nq9V50DTxzrkaVOS/GyZ5XqMV0i47ylXVi
	d9BTyUyrV6gvH7+4lU8AidQsg0AU5p3PydO6QDCOQvqp9Se0f1ObvBSqee+CU6T1jtZuMqn5moh4X
	a/Vazdgg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gSQPO-00018m-S8; Thu, 29 Nov 2018 17:47:26 +0000
Received: from mail-lf1-x144.google.com ([2a00:1450:4864:20::144])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gSQPK-00016u-MN
 for linux-arm-kernel@lists.infradead.org; Thu, 29 Nov 2018 17:47:24 +0000
Received: by mail-lf1-x144.google.com with SMTP id a16so2110314lfg.3
 for <linux-arm-kernel@lists.infradead.org>;
 Thu, 29 Nov 2018 09:47:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=Ypw3E2cISa9isgMf/o7XITSEw9/wZqS4XM12LoMTkow=;
 b=kQ6AMKNVLBIpJnHJzhxVxBdeq6p4dRybfKd57cLFV+11FP5f2nQ2zAotum0p+il6Iz
 Iu7IU385nMt69p6FNuUzimW1rcCMaGJIqXsH8MraCfMA4Cd+Bk9a2R6nL72vE6dH/Cfp
 jQdnCajc65WnxPqJTNJ8OVFtAPOEQ2cqKOa5k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=Ypw3E2cISa9isgMf/o7XITSEw9/wZqS4XM12LoMTkow=;
 b=OxCQpzD9AW01IQgFSIRF3Zpe73pmheJz89/UCpmjfR8fnQn/oOR6d9i2k7JubxQLDc
 Q5a6qYVocFzG5nwyxHl6zt+ILnI2qRcVlpcP0pyeb9Fn3eNc6YEWiMyTkKYQrmj9nYOU
 tzrrr+ULtEIHAofi64oJ5cSjLjX+uhnpABtvy9Tn7wDsAvUoVllJgu/g1U9tGf1/fhak
 5E8H0UZK7vEifoD5ucs/TXdW5OPNtRaFi1RI7eUP0QMzrIxbGWLpGvvT5UeZ32BNkCMV
 VgSbwxrll+kBxsZqXO4cQekvBlgs82CVXDzDYrVJSUOF8o4tLigfTf9VnOtT+ojhKh3V
 v/og==
X-Gm-Message-State: AA+aEWYUBo59gehSAH7+3QZQlvmFb592ShETRZo3p4fBUHuDJrVaTBP3
 OMII5a3lmuzWJl0FmpBrUXNQnw==
X-Google-Smtp-Source: AFSGD/WGJvop+182h8FNuMwezP92yqweV+YNjAIn/s145RayhnjXYyQ8qAfoLBs5uYoyAD30ooBrkw==
X-Received: by 2002:a19:6a13:: with SMTP id u19mr1590988lfu.46.1543513639324; 
 Thu, 29 Nov 2018 09:47:19 -0800 (PST)
Received: from localhost.localdomain (h-158-174-22-210.NA.cust.bahnhof.se.
 [158.174.22.210])
 by smtp.gmail.com with ESMTPSA id j76-v6sm393983ljb.12.2018.11.29.09.47.17
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 29 Nov 2018 09:47:18 -0800 (PST)
From: Ulf Hansson <ulf.hansson@linaro.org>
To: "Rafael J . Wysocki" <rjw@rjwysocki.net>,
 Sudeep Holla <sudeep.holla@arm.com>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>,
 Mark Rutland <mark.rutland@arm.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v10 06/27] of: base: Add of_get_cpu_state_node() to get idle
 states for a CPU node
Date: Thu, 29 Nov 2018 18:46:39 +0100
Message-Id: <20181129174700.16585-7-ulf.hansson@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181129174700.16585-1-ulf.hansson@linaro.org>
References: <20181129174700.16585-1-ulf.hansson@linaro.org>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181129_094722_743248_E95F28A8 
X-CRM114-Status: GOOD (  20.29  )
X-BeenThere: linux-arm-kernel@lists.infradead.org
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-arm-kernel.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-arm-kernel/>
List-Post: <mailto:linux-arm-kernel@lists.infradead.org>
List-Help: <mailto:linux-arm-kernel-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-arm-kernel>, 
 <mailto:linux-arm-kernel-request@lists.infradead.org?subject=subscribe>
Cc: devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Kevin Hilman <khilman@kernel.org>, Stephen Boyd <sboyd@kernel.org>,
 Viresh Kumar <viresh.kumar@linaro.org>, linux-kernel@vger.kernel.org,
 Lina Iyer <ilina@codeaurora.org>, Tony Lindgren <tony@atomide.com>,
 Rob Herring <robh+dt@kernel.org>, linux-arm-msm@vger.kernel.org,
 "Raju P . L . S . S . S . N" <rplsssn@codeaurora.org>,
 linux-arm-kernel@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

The CPU's idle state nodes are currently parsed at the common cpuidle DT
library, but also when initializing back-end data for the arch specific CPU
operations, as in the PSCI driver case.

To avoid open-coding, let's introduce of_get_cpu_state_node(), which takes
the device node for the CPU and the index to the requested idle state node,
as in-parameters. In case a corresponding idle state node is found, it
returns the node with the refcount incremented for it, else it returns
NULL.

Moreover, for ARM, there are two generic methods, to describe the CPU's
idle states, either via the flattened description through the
"cpu-idle-states" binding [1] or via the hierarchical layout, using the
"power-domains" and the "domain-idle-states" bindings [2]. Hence, let's
take both options into account.

[1]
Documentation/devicetree/bindings/arm/idle-states.txt
[2]
Documentation/devicetree/bindings/arm/psci.txt

Cc: Rob Herring <robh+dt@kernel.org>
Cc: devicetree@vger.kernel.org
Cc: Lina Iyer <ilina@codeaurora.org>
Suggested-by: Sudeep Holla <sudeep.holla@arm.com>
Co-developed-by: Lina Iyer <lina.iyer@linaro.org>
Signed-off-by: Ulf Hansson <ulf.hansson@linaro.org>
Reviewed-by: Rob Herring <robh@kernel.org>
---

Changes in v10:
	- None.

---
 drivers/of/base.c  | 35 +++++++++++++++++++++++++++++++++++
 include/linux/of.h |  8 ++++++++
 2 files changed, 43 insertions(+)

diff --git a/drivers/of/base.c b/drivers/of/base.c
index 09692c9b32a7..8f6974a22006 100644
--- a/drivers/of/base.c
+++ b/drivers/of/base.c
@@ -429,6 +429,41 @@ int of_cpu_node_to_id(struct device_node *cpu_node)
 }
 EXPORT_SYMBOL(of_cpu_node_to_id);
 
+/**
+ * of_get_cpu_state_node - Get CPU's idle state node at the given index
+ *
+ * @cpu_node: The device node for the CPU
+ * @index: The index in the list of the idle states
+ *
+ * Two generic methods can be used to describe a CPU's idle states, either via
+ * a flattened description through the "cpu-idle-states" binding or via the
+ * hierarchical layout, using the "power-domains" and the "domain-idle-states"
+ * bindings. This function check for both and returns the idle state node for
+ * the requested index.
+ *
+ * In case and idle state node is found at index, the refcount incremented for
+ * it, so call of_node_put() on it when done. Returns NULL if not found.
+ */
+struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					  int index)
+{
+	struct of_phandle_args args;
+	int err;
+
+	err = of_parse_phandle_with_args(cpu_node, "power-domains",
+					"#power-domain-cells", 0, &args);
+	if (!err) {
+		struct device_node *state_node =
+			of_parse_phandle(args.np, "domain-idle-states", index);
+
+		of_node_put(args.np);
+		return state_node;
+	}
+
+	return of_parse_phandle(cpu_node, "cpu-idle-states", index);
+}
+EXPORT_SYMBOL(of_get_cpu_state_node);
+
 /**
  * __of_device_is_compatible() - Check if the node matches given constraints
  * @device: pointer to node
diff --git a/include/linux/of.h b/include/linux/of.h
index a5aee3c438ad..f9f0c65c095c 100644
--- a/include/linux/of.h
+++ b/include/linux/of.h
@@ -348,6 +348,8 @@ extern const void *of_get_property(const struct device_node *node,
 				int *lenp);
 extern struct device_node *of_get_cpu_node(int cpu, unsigned int *thread);
 extern struct device_node *of_get_next_cpu_node(struct device_node *prev);
+extern struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+						 int index);
 
 #define for_each_property_of_node(dn, pp) \
 	for (pp = dn->properties; pp != NULL; pp = pp->next)
@@ -762,6 +764,12 @@ static inline struct device_node *of_get_next_cpu_node(struct device_node *prev)
 	return NULL;
 }
 
+static inline struct device_node *of_get_cpu_state_node(struct device_node *cpu_node,
+					int index)
+{
+	return NULL;
+}
+
 static inline int of_n_addr_cells(struct device_node *np)
 {
 	return 0;
-- 
2.17.1


_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
