Return-Path: <SRS0=7dGx=OX=lists.infradead.org=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_NEOMUTT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B544DC43387
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:45:21 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B2E820675
	for <infradead-linux-arm-kernel@archiver.kernel.org>; Fri, 14 Dec 2018 14:45:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="U0FHmHxi"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B2E820675
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=aPRBFskCMqm4htFHO8WZB4DWW4iXHWb5ENBFLLlbtVk=; b=U0FHmHxi4IY8k/
	k19z0Q22ndNdvWSgTIxQTJpUL7JG0g8Ij5c0NT8uA/ZUPzCPdNwwdUqBOVjg3QJ1aoKIwmSW/LKuS
	d7V4wIWiOqRUhe8PrFcMXfOGbuuGQ5MdATklLVUsRpucXd8c+BEXGLjQJMdsxnDfu3DrE7nPIGIUe
	thyyL5qFHJHQ/SBIdMwxzM+Gd+N7O3S0pGAU3PdPHwBOIJ5Xj1/zngaT4mFy/87KuQpHENbZieoNw
	1LzjKOTDV7COPEsugl29N8E10Xc3hC9vovWkWsyPcTosmGjIC8dnw8PwJewXJDPHQF4RoS1uvqZY+
	h8MiPO1wTUTC1nBiCKxg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.90_1 #2 (Red Hat Linux))
	id 1gXoiN-0006B5-JS; Fri, 14 Dec 2018 14:45:19 +0000
Received: from mx1.redhat.com ([209.132.183.28])
 by bombadil.infradead.org with esmtps (Exim 4.90_1 #2 (Red Hat Linux))
 id 1gXoi5-0004rs-NL
 for linux-arm-kernel@lists.infradead.org; Fri, 14 Dec 2018 14:45:07 +0000
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mx1.redhat.com (Postfix) with ESMTPS id 1795FC06C9FB;
 Fri, 14 Dec 2018 14:44:51 +0000 (UTC)
Received: from kamzik.brq.redhat.com (unknown [10.43.2.160])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C938E1054FDD;
 Fri, 14 Dec 2018 14:44:49 +0000 (UTC)
Date: Fri, 14 Dec 2018 15:44:47 +0100
From: Andrew Jones <drjones@redhat.com>
To: Dave Martin <Dave.Martin@arm.com>
Subject: Re: [PATCH v2 1/2] KVM: arm64: Filter out invalid core register IDs
 in KVM_GET_REG_LIST
Message-ID: <20181214144447.5fax3f3k7lbwrdo7@kamzik.brq.redhat.com>
References: <1544645824-16461-1-git-send-email-Dave.Martin@arm.com>
 <1544645824-16461-2-git-send-email-Dave.Martin@arm.com>
 <20181213183038.GC3505@e103592.cambridge.arm.com>
 <20181214142545.25rj2haxhhhzw4px@kamzik.brq.redhat.com>
 <20181214144119.GG3505@e103592.cambridge.arm.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20181214144119.GG3505@e103592.cambridge.arm.com>
User-Agent: NeoMutt/20180716
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16
 (mx1.redhat.com [10.5.110.32]); Fri, 14 Dec 2018 14:44:51 +0000 (UTC)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20181214_064502_530383_E6EC8655 
X-CRM114-Status: GOOD (  20.64  )
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
Cc: Marc Zyngier <marc.zyngier@arm.com>, kvmarm@lists.cs.columbia.edu,
 stable@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-arm-kernel" <linux-arm-kernel-bounces@lists.infradead.org>
Errors-To: linux-arm-kernel-bounces+infradead-linux-arm-kernel=archiver.kernel.org@lists.infradead.org

On Fri, Dec 14, 2018 at 02:41:21PM +0000, Dave Martin wrote:
> On Fri, Dec 14, 2018 at 03:25:45PM +0100, Andrew Jones wrote:
> > 
> > Hi Dave,
> > 
> > The below looks like a nice kvm selftest. Care to fit it into that
> > framework (tools/testing/selftests/kvm/) and post it?
> 
> Sure, it makes sense not to drop this on the floor.  Do you feel the
> test needs to go in alongside the fix, or is it alright if I repost this
> later on?

I'm fine with it getting posted whenever. I'll just be happy that it gets
posted :-)

Thanks,
drew

> 
> It will need a bit of cleanup, and I'm juggling other stuff too...
> 
> Cheers
> ---Dave
> 
> > 
> > Thanks,
> > drew
> > 
> > > [1]
> > > 
> > > #include <assert.h>
> > > #include <errno.h>
> > > #include <limits.h>
> > > #include <stddef.h>
> > > #include <stdio.h>
> > > #include <stdlib.h>
> > > #include <stdint.h>
> > > #include <string.h>
> > > #include <fcntl.h>
> > > #include <sys/ioctl.h>
> > > #include <linux/kvm.h>
> > > 
> > > #define KVM_PATH "/dev/kvm"
> > > 
> > > #define ARRAY_SIZE(array) (sizeof (array) / sizeof *(array))
> > > 
> > > static int get_reg_list(int vcpu, struct kvm_reg_list **pregs, size_t *psize)
> > > {
> > > 	struct kvm_reg_list *regs = *pregs;
> > > 	size_t num_needed = 0;
> > > 	const size_t reg_offset = (char *)&regs->reg - (char *)regs;
> > > 
> > > 	while (1) {
> > > 		size_t size_needed = num_needed * sizeof regs->reg[0]
> > > 					+ reg_offset;
> > > 		if (size_needed > *psize) {
> > > 			regs = realloc(regs, size_needed);
> > > 			if (!regs)
> > > 				goto nomem;
> > > 
> > > 			*pregs = regs;
> > > 			*psize = size_needed;
> > > 		}
> > > 
> > > 		regs->n = (*psize - reg_offset) / sizeof regs->reg[0];
> > > 		if (!ioctl(vcpu, KVM_GET_REG_LIST, regs))
> > > 			break;
> > > 
> > > 		if (errno != E2BIG) {
> > > 			perror("KVM_GET_REG_LIST");
> > > 			goto error;
> > > 		}
> > > 
> > > 		num_needed = regs->n;
> > > 	}
> > > 
> > > 	return 0;	
> > > 
> > > nomem:
> > > 	errno = ENOMEM;
> > > 	perror(NULL);
> > > error:
> > > 	return -1;
> > > }
> > > 
> > > int main(void)
> > > {
> > > 	int fail = 0;
> > > 	int kvm_fd, vm, vcpu;
> > > 	struct kvm_vcpu_init init;
> > > 	size_t i;
> > > 	struct kvm_reg_list *regs = NULL;
> > > 	size_t regs_size = 0;
> > > 	uint64_t regdata[2];
> > > 	struct kvm_one_reg reg;
> > > 
> > > 	kvm_fd = open(KVM_PATH, O_RDWR);
> > > 	if (kvm_fd == -1) {
> > > 		perror(KVM_PATH);
> > > 		goto error;
> > > 	}
> > > 
> > > 	vm = ioctl(kvm_fd, KVM_CREATE_VM, 0);
> > > 	if (vm == -1) {
> > > 		perror("KVM_CREATE_VM");
> > > 		goto error;
> > > 	}
> > > 
> > > 	if (ioctl(vm, KVM_ARM_PREFERRED_TARGET, &init)) {
> > > 		perror("KVM_ARM_PREFERRED_TARGET");
> > > 		goto error;
> > > 	}
> > > 
> > > 	printf("KVM_ARM_PREFERRED_TARGET:\n"
> > > 	       "\ttarget = %lu\n",
> > > 	       (unsigned long)init.target);
> > > 	for (i = 0; i < ARRAY_SIZE(init.features); ++i)
> > > 		printf("\tfeatures[0] = 0x%.8lx\n",
> > > 		       (unsigned long)init.features[i]);
> > > 	
> > > 	vcpu = ioctl(vm, KVM_CREATE_VCPU, 0);
> > > 	if (vcpu == -1) {
> > > 		perror("KVM_CREATE_VCPU");
> > > 		goto error;
> > > 	}
> > > 
> > > 	if (!get_reg_list(vcpu, &regs, &regs_size)) {
> > > 		fputs("Strange, KVM_GET_REG_LIST succeeded before KVM_VCPU_INIT!\n",
> > > 		      stderr);
> > > 			
> > > 		goto error;
> > > 	}
> > > 
> > > 	if (ioctl(vcpu, KVM_ARM_VCPU_INIT, &init)) {
> > > 		perror("KVM_ARM_VCPU_INIT");
> > > 		goto error;
> > > 	}
> > > 
> > > 	if (get_reg_list(vcpu, &regs, &regs_size))
> > > 		goto error;
> > > 
> > > 	assert(1 <= -1ULL >> 32);
> > > 	assert(ULONG_MAX >= (1ULL << 32) - 1);
> > > 	for (i = 0; i < regs->n; ++i) {
> > > 		size_t size;
> > > 		char const *s1 = "OK", *s2 = "", *s3 = "";;
> > > 
> > > 		size = (size_t)1 << ((regs->reg[i] & KVM_REG_SIZE_MASK) >>
> > > 				     KVM_REG_SIZE_SHIFT);
> > > 		if (size < 4 || size > 16) {
> > > 			s1 = "BADSIZE";
> > > 			fail = 1;
> > > 		} else {
> > > 			memset(&reg, 0, sizeof reg);
> > > 
> > > 			reg.id = regs->reg[i];
> > > 			reg.addr = (__u64)&regdata;
> > > 			if (ioctl(vcpu, KVM_GET_ONE_REG, &reg)) {
> > > 				s1 = "FAIL (";
> > > 				s2 = strerror(errno);
> > > 				s3 = ")";
> > > 				fail = 1;
> > > 			}
> > > 		}
> > > 
> > > 		printf("\t0x%.16lx\t%s%s%s\n",
> > > 		       (unsigned long)reg.id, s1, s2, s3);
> > > 	
> > > 	}
> > > 
> > > 	if (ferror(stdout) || fflush(stdout))
> > > 		goto stdout_error;
> > > 	
> > > 	if (fail) {
> > > 		puts("FAIL");
> > > 		goto error;
> > > 	}
> > > 
> > > 	if (puts("\nPASS") == EOF || fclose(stdout))
> > > 		goto stdout_error;
> > > 
> > > 	return EXIT_SUCCESS;
> > > 
> > > stdout_error:
> > > 	fputs("I/O error", stderr);
> > > error:
> > > 	return EXIT_FAILURE;
> > > }
> > > _______________________________________________
> > > kvmarm mailing list
> > > kvmarm@lists.cs.columbia.edu
> > > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm
> > _______________________________________________
> > kvmarm mailing list
> > kvmarm@lists.cs.columbia.edu
> > https://lists.cs.columbia.edu/mailman/listinfo/kvmarm

_______________________________________________
linux-arm-kernel mailing list
linux-arm-kernel@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
